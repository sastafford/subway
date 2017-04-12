# Installation

Install the MarkLogic database and application server

     ./gradlew mlDeploy
     

Load the subway data

    ./gradlew importSubwayData


Harmonize the data
  1. Open a QConsole window on the host where your MarkLogic instance has been installed: http://localhost:8000/qconsole
  2. Change the Query Type dropdown to "XQuery"
  3. Change the Database dropdown to "subway-content"
  4. Type in the following xquery module


      xdmp:invoke("/ext/transform/split-nyc-subway-kml.xqy")
      
  5. To confirm the harmonize step worked, press the Explore button, there should be 474 documents avaialble.  
