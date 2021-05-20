extern crate minigrep;

use std::{env, process};
use minigrep::Config;

fn main() {
    let x = 5;
    let y = &x;

    assert_eq!(5, x);
    assert_eq!(5, *y);

    let config = Config::new(env::args()).unwrap_or_else(|err| {
        eprintln!("Problem parsing arguments: {}", err);
        process::exit(1);
    });

    // {}を探しています
    println!("Searching for {}", config.query);
    // {}というファイルの中
    println!("In file {}", config.filename);

    // https://doc.rust-jp.rs/book-ja/ch06-03-if-let.html
    // if letはmatchのsyntax sugar
    if let Err(e) = minigrep::run(config) {
        println!("Application Err: {}", e);
        process::exit(1);
    }
}
