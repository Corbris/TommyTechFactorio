const glob = require("glob");
var fs = require('fs');
var ModListJson = [];

var getDirectories = function (src, callback) {
  glob(src + 'C:/Users/KevinLucas/Desktop/factorio_mods/*/*/info.json', callback);
};

getDirectories('', function (err, res) {
  if (err) {
    console.log('Error', err);
  } else {
	fetchModJson(res);
  }
});

function fetchModJson(dirList){
	let promises = [];
	dirList.forEach((moddir, index) => {
		let p = new Promise((resolve, reject) => {
			fs.readFile(moddir, 'utf8', function (err, data) {
			  if (err) throw err;
			  
			  let info = JSON.parse(data);
			  ModListJson.push(info);
			  resolve(info);
			});
		});
		promises.push(p);
	});
	
	Promise.all(promises).then(() => {
		//console.log(ModListJson);
		saveJson();
		saveCSV();
		
	});
};

function arrayToCSV (data) {
  csv = data.map(row => Object.values(row));
  csv.unshift(Object.keys(data[0]) || " ");
  return csv.join('\n');
}

function saveJson(){
	fs.writeFile('MeshedInfo.json', JSON.stringify(ModListJson, null, 4), 'utf8', (err) => {
		if (err) throw err;
	});
}

function saveCSV(){
	fs.writeFile('MeshedInfo.csv', arrayToCSV(ModListJson), 'utf8', (err) => {
		if (err) throw err;
	});
}