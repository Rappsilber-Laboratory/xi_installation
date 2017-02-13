<?php
    // this script can be used to set up the first user in the database with 'administrator' status
    // (or can be called if all administrator group users have unfortunately been deleted at a later date)
    //
    // keep it outside web root to stop it getting called externally
    //
    // call as php adameve.php --username="username" --email="admin@yourxi.org" --password="1234" --connectConfig="/pathto/connectionString.php"
    if (defined('STDIN')) {
        
        $options = getopt("", array("username:", "email:", "password:", "connectConfig:"));
        echo (print_r ($options, true));
        
        if (isset($options["connectConfig"]) && isset($options["email"]) && isset($options["username"]) && isset($options["password"])) {
            echo ("adameve.php: All options present");
            $pword = $options["password"];
            $username = $options["username"];
            $email = $options["email"];
            
            include ($options["connectConfig"]);
            
            
            $dbconn = pg_connect($connectionString);
            try {
                pg_query("BEGIN") or die("Could not start transaction\n");
                $hash = $pword ? password_hash ($pword, PASSWORD_BCRYPT) : "";
                $newUser = pg_prepare($dbconn, "newUser", "INSERT INTO users (user_name, password, email, max_aas, max_spectra) VALUES($1, $3, $2, 100000000, 100000) RETURNING id, user_name");
                $result = pg_execute($dbconn, "newUser", [$username, $email, $hash]);
                $returnRow = pg_fetch_assoc ($result); // return the inserted row (or selected parts thereof)
                $returnedID = $returnRow["id"];

                $addUserToGroup = pg_prepare($dbconn, "addUserToGroup", "INSERT INTO user_in_group (user_id, group_id) VALUES($1, $2)");
                $result = pg_execute($dbconn, "addUserToGroup", [$returnedID, "5"]);

                 pg_query("COMMIT");
                 echo ("adameve.php: original admin user added");

            } catch (Exception $e) {
                pg_query("ROLLBACK");
                echo ("adameve.php: error when adding original admin user: ".$e);
            }
            
        } else {
            echo ("adameve.php: Missing 1+ of password, email, username, connectConfig");
        }
    }

?>