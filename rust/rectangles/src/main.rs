use std::collections::HashMap;
use std::fs::File;

#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }
}


enum Option<T> {
    Some(T),
    None,
}

fn main() {
    let rect1 = Rectangle { width: 30, height: 50 };

    let mut s = String::from("foo");
    s.push_str("bar");

    let teams  = vec![String::from("Blue"), String::from("Yellow")];
    let initial_scores = vec![10, 50];
    let team_hash = teams.iter().zip(initial_scores.iter());

    let _scores: HashMap<_, _> = team_hash.collect();

    let field_name = String::from("Favorite color");
    let field_value = String::from("Blue");

    let mut map = HashMap::new();
    map.insert(field_name, field_value);

    let mut scores = HashMap::new();

    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Yellow"), 50);

    let team_name = String::from("Blue");
    let _score = scores.get(&team_name);

    scores.insert(String::from("Blue"), 10);
    scores.insert(String::from("Blue"), 25);
    println!("{:?}", scores);

    println!(
        "The area of the rectangle is {} square pixels.",
        rect1.area()
    );

    let f: Result<File, E> = File::open("hello.txt");

    let integer = Some(5);
    let float = Some(5.0);
}

