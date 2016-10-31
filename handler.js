
function uploadFileToS3(filePath, event, cb){ 
    cb('uploadFileToS3');
    var AWS = require('aws-sdk');
    var s3 = new AWS.S3();
    var file = require('fs').createReadStream(filePath);
    var params = {Bucket: event.bucket, Key: event.test + ".xml", Body: file};
    cb(params);
    s3.upload(params, function(err, data) {
        if (err) console.log(err, err.stack); // an error occurred
        else console.log(data);           // successful response

        cb('event.test + ".xml" move to S3 to event.bucket');

	});        
}

function runTest(event, context, cb){ 

	const exec = require('child_process').exec;

    exec("export API_GATEWAY=" + event.apy_gateway + "; cp -a FitNesseRoot /tmp; chmod 755 /tmp; java -jar fitnesse-standalone.jar -d '/tmp' -c '" + event.test + "?test&format=xml&includehtml' -b '/tmp/" + event.test + ".xml' -p 8003; cat '/tmp/" + event.test + ".xml'", (error, stdout, stderr) => {
	  if (error) {
	    console.error(`exec error: ${error}`);
	    return;
	  }
	  console.log(`stdout: ${stdout}`);
	  console.log(`stderr: ${stderr}`);
      uploadFileToS3("/tmp/" + event.test + ".xml", event, console.log)
      cb(null, { ok: true })
	});

};

module.exports.lambdaFitnesse = runTest

if (require.main === module) {
  runTest({ test: "test" }, null, console.log)
}

