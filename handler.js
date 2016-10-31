
function runTest(event, context, cb){ 

	const exec = require('child_process').exec;
    exec("export API_GATEWAY=" + event.apy_gateway + "; cp -a FitNesseRoot /tmp; chmod 755 /tmp; java -jar fitnesse-standalone.jar -d '/tmp' -c '" + event.test + "?test&format=xml&includehtml' -b '/tmp/" + event.test + ".xml' -p 8003; cat '/tmp/" + event.test + ".xml'", (error, stdout, stderr) => {
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

