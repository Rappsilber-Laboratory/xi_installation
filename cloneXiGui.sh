cd /var/www/html; # make this the web server directory you would like to use

git clone https://github.com/Rappsilber-Laboratory/CLMS-model.git;
git clone https://github.com/Rappsilber-Laboratory/searchSubmit.git;
git clone https://github.com/Rappsilber-Laboratory/CLMS-UI.git;
git clone https://github.com/Rappsilber-Laboratory/crosslink-viewer.git;
git clone https://github.com/Rappsilber-Laboratory/spectrum.git;
git clone https://github.com/Rappsilber-Laboratory/history.git;
git clone https://github.com/Rappsilber-Laboratory/userGUI.git;

mv CLMS-UI xi3; # this is necessary, other projects link to content in 'xi3'
