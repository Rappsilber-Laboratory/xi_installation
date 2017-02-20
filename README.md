# xi_installation

A full installation of the xi search software and software needed for browsing its results. Acknowledgements at bottom of this file.

### Citations:
Currently, please use following:
##### For XiSearch:
Giese, S.H., Fischer, L. & Rappsilber, J., 2016. A Study into the Collision-induced Dissociation (CID) Behavior of Cross-Linked Peptides. Molecular & cellular proteomics : MCP, 15(3), pp.1094–1104.

##### For XiGui:
Combe, C.W., Fischer, L. & Rappsilber, J., 2015. xiNET: Cross-link Network Maps With Residue Resolution. Molecular & cellular proteomics: MCP, 14(4), pp.1137–1147.

### Stand-alone mode

Its possible to run XiSearch in 'stand-alone' mode where you just direct it to the input and it outputs CSV data. Start XiSearch as in step 3 below but without any command line options:
```
java -cp "XiSearch.jar" rappsilber.applications.Xi
```
More detailed documentation for stand-alone mode is ? in the XiSearch project?

### Full Installation Instructions
(sketchy, untested, needs work)

1. Set up your machine. A [linux](http://serverfault.com/questions/222430/is-postgresql-suited-to-one-os-is-it-better-on-linux-than-windows#222479) machine with Apache & php5, Postgres (>9.4), and Oracle's Java 1.8. The maximum size of the search space (maximum size of FASTA file) is determined by the memory available to XiSearch. Depending on the resources available to you, you may want to run XiSearch on one machine and the database and web server on another.

2. Set up your database. Use pg_restore to recreate the database schema from the file dbSchema.sql contained herein. Then populate various required tables from requiredTables.sql using pg_restore. You need the data in these tables to start searches. *Note: these SQL dumps assign ownership of things to a role called "myXi3_user", you may want to change this (search and replace on the sql dumps) to something other people don't know for the sake of the security of your xi installation.*

3. Create a directory to store uploaded data in. By default this is /xi_data/ , it is set in the base_settings table populated by requiredTables.sql.

4. Start the java Xi search software.
   ```java -cp "XiSearch.jar:postgresql-9.4.1209.jar" rappsilber.applications.Xi -yo```
    will print out usage instructions. Use the --exampleconfig option to generate an example config file, then edit this and point XiSearch to it when you start it. When you start it, also use the -Xmx option to set the maximun heap size as high as possible.
    
5. Install the web interface. The shell script `cloneXiGui.sh` will clone the git projects; read it and edit the webserver folder before running.
6. Edit `credentials.ini` to have real values. There are 3 accounts to set details for in here:
  1. The Xi database connection.
  2. An external email account used for sending registration / password reset emails - which also needs a google recaptcha key.
  3. The first Xi user in the database (who will be a superuser.)
7. Then run `"php php/makeCredentials.php credentials.ini"`. This will make `connectionString.php` (which should then be placed in the same directory as the cloned github projects), `emailInfo.php` (which should then be placed in a sibling folder to the web root called `xi_ini`) and also create the first user in the database.
```
    |
    \---your_server/
        +---www/
        |   |   connectionString.php
        |   +---xi3/
        |   +---searchSubmit/
        |   \---etc etc
        |
        \---xi_ini/
                emailInfo.php
```  
8. `set_xi_phpinivalues.sh` is a script that sets necessary values in `php.ini` to allow large file uploads in the Search Submission page. Run this script in the directory that `php.ini` is in (or in a parent directory of it, it will find all instances of `php.ini` beneath the point it is run at).

9. You should also be able to view results via the web gui but annotated spectra will not be available until XiAnnotator is started.

10. Start XiAnnotator, ~~similar to starting XiSearch, more details to follow...~~ It should be started as a service, [see documentation](https://github.com/Rappsilber-Laboratory/xiAnnotator/tree/master/doc).

##### TODO?
include XiFDR and instructions for advanced FDR analysis?
wrap whole thing up in a Docker container?


#### Acknowledgements

##### Principle Investigator
Juri Rappsilber,
Wellcome Trust Centre for Cell Biology, School of Biological Sciences, University of Edinburgh, Edinburgh EH9 3BF, United Kingdom
&
Chair of Bioanalytics, Institute of Biotechnology, Technische Universität Berlin, 13355 Berlin, Germany

##### Funding
Wellcome Trust, grant numbers 084229, 103139.

##### Researchers / developers
(specific github projects contributed to in brackets, could include our github user names?).

XiSearch Java software -
- Lutz Fischer (XiSearch, XiAnnotator, XiFDR if its included)

XiGui -
- Martin Graham (CLMS-UI, searchSubmit, history, userGUI),
- Colin Combe (CLMS-model, CLMS-UI, crosslink-viewer, spectrum),
- Lars Koblowski (spectrum)
- Alexander Rose ([NGL](https://github.com/arose/ngl), integration of NGL 3D viewer into CLMS-UI)
