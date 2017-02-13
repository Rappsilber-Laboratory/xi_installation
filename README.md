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

   5. Install the web interface. The shell script cloneXiGui.sh will clone the git projects; read it and edit the webserver folder before running.

   6. Edit the config files for web interface and copy them to the web folder the git projects were cloned into. These files are emailInfo.php, used by user admin functions such as password reset, and connectionString.php which has the connection details for your database.

   7. Create an initial user by running adameve.php. Syntax is php adameve.php --username="username" --email="admin@yourxi.org" --password="1234" --connectConfig="/pathto/connectionString.php"

   8. You should also be able to view results via the web gui but annotated spectra will not be available until XiAnnotator is started.

   9. Start XiAnnotator, ~~similar to starting XiSearch, more details to follow...~~ It should be started as a service, [see documentation](https://github.com/Rappsilber-Laboratory/xiAnnotator/tree/master/doc).

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
