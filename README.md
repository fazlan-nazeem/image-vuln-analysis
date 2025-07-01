# image-vuln-analysis
Analyses image vulnerabilities of a given list of images via [Docker Scout](https://docs.docker.com/scout/)

This script has been implemented to only ouput *critical* and *high* severrity vulnerabilities.


## How to Use

- List the images that need to be analyzed in `versions.txt` file. Existing file is populated with different alpine versions for demonstration purpose.

- Executing the following command will write the output to `results.txt` file

  `./script.sh versions.txt > results.txt`

