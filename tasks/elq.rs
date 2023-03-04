
use std::env;
use clap::{App, Arg};
use clap::{App, Arg};
use elasticsearch::{Elasticsearch, SearchParts, Transport};
use serde::{Deserialize, Serialize};
use serde_json::Value;
use prettytable::{Table, Row, Cell};

const PROGRAM: &str = "elq";
const VERSION: &str = "1.0.0";


// Die Datenstruktur, um den Inhalt von Elasticsearch Antwort zu speichern
#[derive(Debug, Deserialize, Serialize)]
struct SearchResult {
    #[serde(rename = "_source")]
    source: Value,
}


fn main() {
    let matches = App::new(PROGRAM)
        .version(VERSION)
        .author("Your Name")
        .about("Description of my_tool")
        .arg(
            Arg::with_name("help")
                .short("h")
                .long("help")
                .help("Prints help information"),
        )
        .arg(
            Arg::with_name("version")
                .short("v")
                .long("version")
                .help("Prints version information"),
        )
        .arg(
            Arg::with_name("query")
                .short("q")
                .long("query")
                .value_name("QUERY")
                .help("Sets the query to run in Elasticsearch")
                .required(true),
        )
        .arg(
            Arg::with_name("format")
                .short("f")
                .long("format")
                .value_name("FORMAT")
                .help("Sets the output format (json|table)")
                .takes_value(true),
        )
        .get_matches();

    if matches.is_present("help") {
        println!("{}", matches.usage());
        std::process::exit(0);
    }

    if matches.is_present("version") {
        println!("Version: {}", VERSION);
        std::process::exit(0);
    }

    let es_host = match env::var("ES_HOST") {
        Ok(val) => val,
        Err(_) => String::from("http://localhost:9200"),
    };

    let query = matches.value_of("query").unwrap();
    let format = matches.value_of("format").unwrap_or("table");

    let transport = Transport::single_node(es_host)?;
    let client = Elasticsearch::default(transport).unwrap();
    let response = client
        .search(SearchParts::Index(&["my_index"]))
        .body(json!({
            "query": {
                "match": {
                    "message": {
                        "query": query
                    }
                }
            }
        }))
        .send()
        .unwrap();

    let results: Vec<SearchResult> = response
        .json::<Value>()
        .unwrap()
        .get("hits")
        .unwrap()
        .get("hits")
        .unwrap()
        .as_array()
        .unwrap()
        .iter()
        .map(|r| serde_json::from_value(r["_source"].clone()).unwrap())
        .collect();

    match format {
        "json" => {
            println!("{}", serde_json::to_string_pretty(&results).unwrap());
        }
        "table" => {
            let mut table = Table::new();
            table.add_row(Row::new(vec![
                Cell::new("ID"),
                Cell::new("Timestamp"),
                Cell::new("Message"),
            ]));
            for result in results {
                let id = result.source.get("id").unwrap().as_str().unwrap_or("n/a");
                let timestamp = result.source.get("@timestamp").unwrap().as_str().unwrap_or("n/a");
                let message = result.source.get("message").unwrap().as_str().unwrap_or("n/a");
                table.add_row(Row::new(vec![
                    Cell::new(id),
                    Cell::new(timestamp),
                    Cell::new(message),
                ]));
            }
            table.printstd();
        }
        _ => {
            println!("Invalid format. Please use --format json|table");
            std::process::exit(1);
        }
    }
}
