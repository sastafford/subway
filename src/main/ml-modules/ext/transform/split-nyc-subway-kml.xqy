xquery version "1.0-ml";
declare namespace kml = "http://earth.google.com/kml/2.2";

let $uri := "/data/Subway-Stations.kml"
let $doc := fn:doc($uri)
for $placemark in $doc/kml/Document/Folder/Placemark
let $pm-uri := fn:concat("/web.mta.info/nyct/service/", $placemark/ExtendedData/Data[@name = "objectid"]/value/text())
let $pm-doc :=
  element kml {
    attribute xmlns { "http://earth.google.com/kml/2.2" },
    element kml:Document {
      attribute id { "featureCollection" },
      element kml:Style {
        attribute id { "defaultStyle" },
        element kml:LineStyle {
          element kml:width { "1.5" }
        },
        element kml:PolyStyle {
          element kml:color { "7d8a30c4" }
        }
      },
      element kml:Placemark {
        element kml:styleUrl { "#defaultStyle" },
        element kml:name { $placemark/name/text() },
        element kml:ExtendedData {
          for $data in $placemark/ExtendedData/Data
          let $name := fn:string($data/@name)
          return
            element kml:Data {
              attribute name { $name },
              element kml:value { $data/value/text() }
            }
        },
        element kml:Point {
          element kml:coordinates { fn:normalize-space($placemark/Point/coordinates/text()) }
        }
      }
    }

  }
return
  xdmp:document-insert(
    $pm-uri,
    $pm-doc,
    (
      xdmp:permission("rest-reader", "read"),
      xdmp:permission("rest-writer", "update")
    ),
    ("kml")
  )