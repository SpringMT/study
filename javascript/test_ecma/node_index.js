class A {
  constructor(fuga) {
    this.fuga = fuga;
  }

  say() {
    console.log(this.fuga);
  }

}

const a = new A('FUGA');
a.say();
