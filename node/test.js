const fs = require('fs');
function getImage(file) {
  return new Promise((res, rej) => {
    try {
      const data = fs.readFile(file)
      res(data)
    } catch(err) {
      rej(new Error(err))
    }
  })
}

getImage('./fixture.jpg')
  .then(image => console.log(image))
  .catch(error => console.log(error))
  .finally(() => console.log('all done'))

