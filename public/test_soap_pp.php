<?php
set_time_limit(0);
$site = "zhtest1";
$randkey = substr(md5(rand().rand()), 0, 8);
$password = sha1('hostedopenemrinstaller@123'.gmdate("Y-m-d H").$randkey);
$credentials = array('hostedopenemrinstaller',$password,$randkey);
$client = new SoapClient(
  null,
  array(
    'location' => "https://www.mydocsportal.com/myservices/soap_service/server_side.php",
    'uri'      => "urn://portal/res",
    'trace'    => 1
  )
);
$validarr = array($credentials, $site);
try{
  $valid = $client->check_existing($validarr);
}catch(Exception $e){
  print_r($e);
}
if(!$valid){
  echo "ERROR. Validation failed in patient portal side in facility id checking\n";
}elseif($valid == 'present'){
  echo "ERROR. Facility id already exists in patient portal side\n";
}
echo "Does not exist";
?>