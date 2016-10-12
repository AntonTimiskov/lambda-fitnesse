def lambda_handler(event, context):

  import subprocess
  subprocess.run(
    ["java", "-jar", "-d", "/binaries/FitnesseRoot", "-c", event.test + "?test&format=xml&includehtml", "-b", event.test + ".xml", "-p", "8080"],
    stdout=subprocess.STDOUT, stderr=subprocess.STDERR)
