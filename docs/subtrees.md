to init
-------

    git remote add Adafruit-Occi git@github.com:adafruit/Adafruit-Occi.git
    git subtree add --prefix=packages/occi/ Adafruit-Occi master

    git remote add Adafruit-Pi-ExternalRoot-Helper git@github.com:adafruit/Adafruit-Pi-ExternalRoot-Helper.git
    git subtree add --prefix=packages/adafruit-pi-externalroot-helper/ Adafruit-Pi-ExternalRoot-Helper master

to update
---------

    git subtree pull --prefix=packages/adafruit-pi-externalroot-helper/ Adafruit-Pi-ExternalRoot-Helper master
    git subtree pull --prefix=packages/occi/ Adafruit-Occi master
