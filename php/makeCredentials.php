<?php
    $config = parse_ini_file ($argv[1], false, INI_SCANNER_NORMAL);

    file_put_contents ("connectionString.php",
        "<?php\r\n\$connectionString = \"host=".$config["dbHost"].
                       " port=".$config["dbPort"]." dbname=".$config["dbName"]." user=".$config["dbUsername"]." password=".$config["dbPassword"]."\"".
                       "\r\n?>\r\n"
    );

    file_put_contents ("emailInfo.php", 
        "<?php\r\n\$secretRecaptchaKey = \"".$config["secretRecaptchaKey"]."\";\r\n\r\n"
                       ."\$mailInfo = array (\r\n"
                       ."\"account\" => \"".$config["emailAccount"]."\",\r\n"
                       ."\"password\" => \"".$config["emailPassword"]."\",\r\n"
                       ."\"host\" => \"".$config["emailHost"]."\",\r\n"
                       ."\"port\" => ".$config["emailPort"]."\r\n"
                       .");\r\n\r\n"
                       ."\$urlRoot = \"".$config["webRoot"]."\";\r\n"
                      ."?>\r\n"
    );

    include 'adameve.php';
?>
