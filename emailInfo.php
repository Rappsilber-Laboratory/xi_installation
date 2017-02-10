<?php
$secretRecaptchaKey = "YourSecretRecaptchaKey"; // get it from google
//*ALSO* change public part of the captcha key in yourWWWdirectory/userGUI/json/config.json

$mailInfo = array (
    "account" => "youremail@address",
    "password" => "yourpassword",
    "host" => "youremailhost",  // often smtp.something.com
    "port" => youremailportnumber
);
$urlRoot = "http://urlofwhereyourxiinstanceishosted";  // cos sniffing it in php via $_SERVER can be set clientside which is bad
?>
