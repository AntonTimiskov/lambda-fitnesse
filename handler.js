
function runTest(event, context, cb){ 

	const exec = require('child_process').exec;
	exec("java -jar fitnesse-standalone.jar -d 'FitnesseRoot' -c '" + event.test + "?test&format=xml&includehtml' -b '" + event.test + ".xml' -p 8080", (error, stdout, stderr) => {
	  if (error) {
	    console.error(`exec error: ${error}`);
	    return;
	  }
	  console.log(`stdout: ${stdout}`);
	  console.log(`stderr: ${stderr}`);
          cb(null, { ok: true })
	});

};

module.exports.lambdaFitnesse = runTest

if (require.main === module) {
  runTest({ test: "test" }, null, console.log)
}
