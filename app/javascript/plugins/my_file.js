function anaMaria() {
  return fetch("http://localhost:3000/get_json")
    .then(response => response.json())
};

let myJson = fetchJson();
console.log(myJson)
