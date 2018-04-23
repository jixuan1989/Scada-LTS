<%--
    Mango - Open Source M2M - http://mango.serotoninsoftware.com
    Copyright (C) 2006-2011 Serotonin Software Technologies Inc.
    @author Matthew Lohbihler
    
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see http://www.gnu.org/licenses/.
--%>
<%@ include file="/WEB-INF/jsp/include/tech.jsp" %>

<tag:page dwr="DataPointEditDwr">

     <link href="resources/app/bower_components/sweetalert2/dist/sweetalert2.min.css" rel="stylesheet" type="text/css">
     <script type="text/javascript" src="resources/app/bower_components/sweetalert2/dist/sweetalert2.min.js"></script>


  <%@ include file="/WEB-INF/jsp/pointEdit/pointName.jsp" %>
  
  <form action="" method="post">
    <input type="hidden" id="taskName" name="asdf" value=""/>
    <table width="100%" cellpadding="0" cellspacing="0">
      <tr>
        <td valign="top">
          <%@ include file="/WEB-INF/jsp/pointEdit/pointProperties.jsp" %>
          <%@ include file="/WEB-INF/jsp/pointEdit/loggingProperties.jsp" %>
          <%@ include file="/WEB-INF/jsp/pointEdit/valuePurge.jsp" %>
          <%@ include file="/WEB-INF/jsp/pointEdit/textRenderer.jsp" %>
          <%@ include file="/WEB-INF/jsp/pointEdit/chartRenderer.jsp" %>
        </td>
        <td valign="top">
          <%@ include file="/WEB-INF/jsp/pointEdit/eventDetectors.jsp" %>
        </td>
      </tr>
      <tr>
        <td>
        </br>
        <div id="base_on_existing_point_chooser">
             <select id="selected_base_on_existing_point_chooser">
               <c:forEach items="${userPoints}" var="point">
                 <sst:option value="${point.id}">${point.extendedName}</sst:option>
               </c:forEach>
             </select>
         </div>
            <script>
                   function showEditChartRender(charRenerer) {
                      jQuery("#chartRendererNone").hide();
                      jQuery("#chartRendererTable").hide();
                      jQuery("#chartRendererImage").hide();
                      jQuery("#chartRendererStats").hide();
                      var selectorChartRenderer = "#" + charRenerer;
                      jQuery(selectorChartRenderer).show();
                   };

                  function baseOnExistingPoint(){
                       var idPointConfigurationToBaseOnExistingPoint = jQuery('#selected_base_on_existing_point_chooser').find(":selected")[0].value;
                       var namePointConfigurationToBaseOnExistingPoint = jQuery('#selected_base_on_existing_point_chooser').find(":selected")[0].text;
                       var swal_message = namePointConfigurationToBaseOnExistingPoint + "</br> id:"+idPointConfigurationToBaseOnExistingPoint;

                       var pathArray = location.href.split( '/' );
                       var protocol = pathArray[0];
                       var host = pathArray[2];
                       var appScada = pathArray[3];
                       var myLocation;
                       if (!myLocation) {
                        myLocation = protocol + "//" + host + "/" + appScada + "/";
                       }

                       var arrDictLoggingType = ["When point value changes", "All data", "Do not log", "Interval", "When point timestamp changes"];

                       var arrDictPurge = ["","","","","day(s)", "week(s)", "month(s)", "year(s)"];

                       var arrDictChartRendererImageTimePeriod = ["","","minute(s)", "hour(s)", "day(s)", "week(s)", "month(s)"];

                       var arrDictEnginneringUnits = [
                                                "square meters", /* 0 */
                                                "square feet",
                                                "milliamperes",
                                                "amperes",
                                                "ohms",
                                                "volts",
                                                "kilovolts",
                                                "megavolts",
                                                "volt amperes",
                                                "kilovolt amperes",
                                                "megavolt amperes", /* 10 */
                                                "volt amperes reactive",
                                                "kilovolt amperes reactive",
                                                "megavolt amperes reactive",
                                                "degrees phase",
                                                "power factor",
                                                "joules",
                                                "kilojoules",
                                                "watt hours",
                                                "kilowatt hours",
                                                "btus",  /* 20 */
                                                "therms",
                                                "ton hours",
                                                "joules per kilogram dry air",
                                                "btus per pound dry air",
                                                "cycles per hour",
                                                "cycles per minute",
                                                "hertz",
                                                "grams of water per kilogram dry air",
                                                "percent relative humidity",
                                                "millimeters", /* 30 */
                                                "meters",
                                                "inches",
                                                "feet",
                                                "watts per square foot",
                                                "watts per square meter",
                                                "lumens",
                                                "luxes",
                                                "foot candles",
                                                "kilograms",
                                                "pounds mass", /* 40 */
                                                "tons",
                                                "kilograms per second",
                                                "kilograms per minute",
                                                "kilograms per hour",
                                                "pounds mass per minute",
                                                "pounds mass per hour",
                                                "watts",
                                                "kilowatts",
                                                "megawatts",
                                                "btus per hour", /* 50 */
                                                "horsepower",
                                                "tons refrigeration",
                                                "pascals",
                                                "kilopascals",
                                                "bars",
                                                "pounds force per square inch",
                                                "centimeters of water",
                                                "inches of water",
                                                "millimeters of mercury",
                                                "centimeters of mercury", /* 60 */
                                                "inches of mercury",
                                                "degrees celsius",
                                                "degrees kelvin",
                                                "degrees fahrenheit",
                                                "degree days celsius",
                                                "degree days fahrenheit",
                                                "years",
                                                "months",
                                                "weeks",
                                                "days", /* 70 */
                                                "hours",
                                                "minutes",
                                                "seconds",
                                                "meters per second",
                                                "",
                                                "feet per second",
                                                "feet per minute",
                                                "miles per hour",
                                                "cubic feet",
                                                "cubic meters", /* 80 */
                                                "imperial gallons",
                                                "liters",
                                                "us gallons",
                                                "cubic feet per minute",
                                                "cubic meters per second",
                                                "imperial gallons per minute",
                                                "liters per second",
                                                "liters per minute",
                                                "us gallons per minute",
                                                "degrees angular", /* 90 */
                                                "degrees celsius per hour",
                                                "degrees celsius per minute",
                                                "degrees fahrenheit per hour",
                                                "degrees fahrenheit per minute",
                                                "no units",
                                                "parts per million",
                                                "parts per billion",
                                                "percent",
                                                "percent per second",
                                                "per minute", /* 100 */
                                                "per second",
                                                "psi per degree fahrenheit",
                                                "radians",
                                                "revolutions per minute",
                                                "currency 1",
                                                "currency 2",
                                                "currency 3",
                                                "currency 4",
                                                "currency 5",
                                                "currency 6", /* 110 */
                                                "currency 7",
                                                "currency 8",
                                                "currency 9",
                                                "currency 10",
                                                "square inches",
                                                "square centimeters",
                                                "btus per pound",
                                                "centimeters",
                                                "pounds mass per second",
                                                "delta degrees fahrenheit", /* 120 */
                                                "delta degrees kelvin",
                                                "kilohms",
                                                "megohms",
                                                "millivolts",
                                                "kilojoules per kilogram",
                                                "megajoules",
                                                "joules per degree kelvin",
                                                "joules per kilogram degree kelvin",
                                                "kilohertz",
                                                "megahertz", /* 130 */
                                                "per hour",
                                                "milliwatts",
                                                "hectopascals",
                                                "millibars",
                                                "cubic meters per hour",
                                                "liters per hour",
                                                "kilowatt hours per square meter",
                                                "kilowatt hours per square foot",
                                                "megajoules per square meter",
                                                "megajoules per square foot", /* 140 */
                                                "watts per square meter degree kelvin",
                                                "cubic feet per second",
                                                "percent obscuration per foot",
                                                "percent obscuration per meter",
                                                "milliohms",
                                                "megawatt hours",
                                                "kilo btus",
                                                "mega btus",
                                                "kilojoules per kilogram dry air",
                                                "megajoules per kilogram dry air", /* 150 */
                                                "kilojoules per degree kelvin",
                                                "megajoules per degree kelvin",
                                                "newton",
                                                "grams per second",
                                                "grams per minute",
                                                "tons per hour",
                                                "kilo btus per hour",
                                                "hundredths seconds",
                                                "milliseconds",
                                                "newton meters", /* 160 */
                                                "millimeters per second",
                                                "millimeters per minute",
                                                ">meters per minute",
                                                "meters per hour",
                                                "cubic meters per minute",
                                                "meters per second per second",
                                                "amperes per meter",
                                                "amperes per square meter",
                                                "ampere square meters",
                                                "farads", /* 170 */
                                                "henrys",
                                                "ohm meters",
                                                "siemens",
                                                "siemens per meter",
                                                "teslas",
                                                "volts per degree kelvin",
                                                "volts per meter",
                                                "webers",
                                                "candelas",
                                                "candelas per square meter", /* 180 */
                                                "degrees kelvin per hour",
                                                "degrees kelvin per minute",
                                                "joule seconds",
                                                "radians per second",
                                                "square meters perNewton",
                                                "kilograms per cubic meter",
                                                "newton seconds",
                                                "newtons per meter",
                                                "watts per meter per degree kelvin",
                                                "", /* 190 */
                                                "",
                                                "",
                                                "",
                                                "",
                                                "",
                                                "",
                                                "",
                                                "",
                                                "",
                                                "" /* 200 */
                                                ];



                       jQuery.ajax({
                            type: "GET",
                            dataType: "json",
                            url:myLocation+"/api/point_properties/getPropertiesBaseOnId/"+idPointConfigurationToBaseOnExistingPoint,
                           					        	   success: function(properties){
                           					        	            swal({
                                                                      html: swal_message
                                                                                 + "</br> Logging type:"+arrDictLoggingType[properties.loggingType]
                                                                                 + "</br> Purge After:"+properties.intervalLoggingPeriod+" "+ arrDictPurge[properties.purgeType]
                                                                                 + "</br> Default cache size: " + properties.defaultCacheSize
                                                                                 + "</br> Type key: " + properties.typeKey
                                                                                 + "</br> Def: " + properties.def.name
                                                                                 + "</br>",
                                                                      buttons: {
                                                                        cancel: true,

                                                                        confirm: "Confirm",
                                                                        icon: "warning",
                                                                        buttons: true,
                                                                        dangerMode: true,
                                                                       },
                                                                     }).then(function(isConfirm) {
                                                                         if (isConfirm) {
                                                                           alert(JSON.stringify(properties));
                                                                           jQuery("#engineeringUnits").val(properties.engineeringUnits);
                                                                           jQuery("#loggingType").val(properties.loggingType);
                                                                           jQuery("#purgePeriod").val(properties.intervalLoggingPeriod);
                                                                           jQuery("#purgeType").val(properties.purgeType);
                                                                           jQuery("#defaultCacheSize").val(properties.defaultCacheSize);

                                                                           var currentTextRenderer = $("textRendererSelect").value;

                                                                           console.log(currentTextRenderer);

                                                                           dojo.html.hide(
                                                                                    $(currentTextRenderer)
                                                                           );

                                                                           jQuery("#textRendererSelect").val(properties.def.name);

                                                                           currentTextRenderer = $("textRendererSelect").value;

                                                                           dojo.html.show(
                                                                                    $(currentTextRenderer)
                                                                           );

                                                                           if (properties.def.name == "textRendererBinary") {
                                                                              jQuery("#textRendererBinaryZero").val(properties.textRenderer.zeroLabel);
                                                                              dojo.widget.byId("textRendererBinaryZeroColour").selectedColour = properties.textRenderer.zeroColour;
                                                                              jQuery("#textRendererBinaryZero").css('color', properties.textRenderer.zeroColour);
                                                                              jQuery("#textRendererBinaryOne").val(properties.textRenderer.oneLabel);
                                                                              jQuery("#textRendererBinaryOne").css('color', properties.textRenderer.oneColour);
                                                                              dojo.widget.byId("textRendererBinaryOneColour").selectedColour = properties.textRenderer.oneColour;
                                                                           }

                                                                           if (properties.def.name == "textRendererPlain") {
                                                                              jQuery("#textRendererPlainSuffix").val(properties.textRenderer.suffix);
                                                                           }

                                                                           if (properties.def.name == "textRendererMultistate") {
                                                                              for (var multistate in properties.textRenderer.multistateValues) {
                                                                                   textRendererEditor.addMultistateValue(
                                                                                        properties.textRenderer.multistateValues[multistate].key,
                                                                                        properties.textRenderer.multistateValues[multistate].text,
                                                                                        properties.textRenderer.multistateValues[multistate].colour
                                                                                   );
                                                                              }
                                                                           }

                                                                           if (properties.def.name == "textRendererAnalog") {
                                                                                jQuery("#textRendererAnalogFormat").val(properties.textRenderer.format);
                                                                                jQuery("#textRendererAnalogSuffix").val(properties.textRenderer.metaText);
                                                                           }

                                                                           if (properties.def.name == "textRendererRange") {
                                                                                jQuery("#textRendererRangeFormat").val(properties.textRenderer.format);
                                                                                for (var range in properties.textRenderer.rangeValues) {
                                                                                    textRendererEditor.addRangeValue(
                                                                                        properties.textRenderer.rangeValues[range].from,
                                                                                        properties.textRenderer.rangeValues[range].to,
                                                                                        properties.textRenderer.rangeValues[range].text,
                                                                                        properties.textRenderer.rangeValues[range].color
                                                                                    );
                                                                                }
                                                                           }

                                                                           if (properties.def.name == "textRendererTime") {
                                                                                jQuery("#textRendererTimeFormat").val(properties.textRenderer.format);
                                                                                jQuery("#textRendererTimeConversionExponent").val(properties.textRenderer.conversionExponent);
                                                                           }

                                                                           if (properties.chartRenderer == null) {
                                                                                jQuery("#chartRendererSelect").val("chartRendererNone");
                                                                                showEditChartRender("chartRendererNone");
                                                                           } else  if (properties.chartRenderer.def.name == "chartRendererImage") {
                                                                                jQuery("#chartRendererSelect").val("chartRendererImage");
                                                                                showEditChartRender("chartRendererImage");
                                                                                jQuery("#chartRendererImageNumberOfPeriods").val(properties.chartRenderer.numberOfPeriods);
                                                                                jQuery("#chartRendererImageTimePeriod").val(properties.chartRenderer.timePeriod);

                                                                                //arrDictChartRendererImageTimePeriod
                                                                           } else if (properties.chartRenderer.def.name == "chartRendererStats") {
                                                                                jQuery("#chartRendererSelect").val("chartRendererStats");
                                                                                showEditChartRender("chartRendererStats");
                                                                                jQuery("#chartRendererStatsNumberOfPeriods").val(properties.chartRenderer.numberOfPeriods);
                                                                                jQuery("#chartRendererStatsTimePeriod").val(properties.chartRenderer.timePeriod);
                                                                                jQuery("#chartRendererStatsIncludeSum").attr('checked', properties.chartRenderer.includeSum);
                                                                           } else if (properties.chartRenderer.def.name == "chartRendererTable") {
                                                                                jQuery("#chartRendererSelect").val("chartRendererTable");
                                                                                showEditChartRender("chartRendererTable");
                                                                                jQuery("#chartRendererTableLimit").val(properties.chartRenderer.limit);
                                                                           }

                                                                           console.log(JSON.stringify(properties));

                                                                         } else {
                                                                           alert("cancel");
                                                                         }
                                                                     });
                           					        	   },
                           					        	   error: function(XMLHttpRequest, textStatus, errorThrown) {
                           					        		   swal({
                                                                  text: "Problem when get properties:"+errorThrown.message,
                                                                  buttons: {
                                                                    cancel: true
                                                                   },
                                                                });
                           					        	   }
                           					        	});
                  }
            </script>
            </br>
            <div id="baseOnTemplate">
                <input id="baseOnExistingPointBtn" type="button" value="Base on existing point" onclick="baseOnExistingPoint()" class="">
            </div>
            </br>
            </br>

        </td>
      </tr>
    </table>

    <%@ include file="/WEB-INF/jsp/pointEdit/buttons.jsp" %>
  </form>
</tag:page>