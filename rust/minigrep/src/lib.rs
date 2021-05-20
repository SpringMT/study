use std::error::Error;
use std::fs::File;
use std::io::prelude::*;

pub fn run(config: Config) -> Result<(), Box<dyn Error>> {
    let mut f = File::open(config.filename)?;

    let mut contents = String::new();
    // https://doc.rust-jp.rs/book-ja/ch09-02-recoverable-errors-with-result.html
    // Okならその値を返して、Errなら早期リターン
    f.read_to_string(&mut contents)?;
    for line in search(&config.query, &contents) {
        println!("{}", line);
    }
    Ok(())
}

pub struct Config {
    pub query: String,
    pub filename: String,
}

impl Config {
    pub fn new(mut args: std::env::Args) -> Result<Config, &'static str> {
        args.next();

        let query = match args.next() {
            Some(arg) => arg,
            // クエリ文字列を取得しませんでした
            None => return Err("Didn't get a query string"),
        };

        let filename = match args.next() {
            Some(arg) => arg,
            // ファイル名を取得しませんでした
            None => return Err("Didn't get a file name"),
        };

        Ok(Config { query, filename })
    }
}

/*
fn parse_config(args: &[String]) -> Config {
    // &args[1].clone() だと cloneした結果の参照を返すことになり型が違ってコンパイルエラー
    let query = args[1].clone();
    let filename = args[2].clone();

    Config { query, filename }
}
*/

// ライフタイム 'aが使われている
// これはライフタイムがcontentsと同じであることを示す
// https://doc.rust-jp.rs/book-ja/ch04-03-slices.html#%E5%BC%95%E6%95%B0%E3%81%A8%E3%81%97%E3%81%A6%E3%81%AE%E6%96%87%E5%AD%97%E5%88%97%E3%82%B9%E3%83%A9%E3%82%A4%E3%82%B9
// https://doc.rust-jp.rs/book-ja/ch10-03-lifetime-syntax.html
pub fn search<'a>(query: &str, contents: &'a str) -> Vec<&'a str> {
    let mut results = Vec::new();
    for line in contents.lines() {
        if line.contains(query) {
            results.push(line);
        }
    }
    return results
}

#[cfg(test)]
mod test {
    // https://doc.rust-jp.rs/book-ja/ch11-01-writing-tests.html
    // testsモジュール内に新しい行を加えたことに注目してください
    // use super::*です。 testsモジュールは、第7章のモジュールツリーの要素を示すための
    // パス節で講義した通常の公開ルールに従う普通のモジュールです。
    // testsモジュールは、内部モジュールなので、
    // 外部モジュール内のテスト配下にあるコードを内部モジュールのスコープに持っていく必要があります。
    // ここではglobを使用して、外部モジュールで定義したもの全てが
    // このtestsモジュールでも使用可能になるようにしています。
    use super::*;

    #[test]
    fn one_result() {
        let query = "duct";
        let contents = "\
Rust:
safe, fast, productive.
Pick three.";

        assert_eq!(
            // https://doc.rust-jp.rs/book-ja/ch08-01-vectors.html?highlight=vec!#enum%E3%82%92%E4%BD%BF%E3%81%A3%E3%81%A6%E8%A4%87%E6%95%B0%E3%81%AE%E5%9E%8B%E3%82%92%E4%BF%9D%E6%8C%81%E3%81%99%E3%82%8B
            // 初期値のあるVec<T>を生成する方が一般的ですし、 Rustには、利便性のためにvec!というマクロも用意されています。
            vec!["safe, fast, productive."],
            search(query, contents)
        );
    }
}