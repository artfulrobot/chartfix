{*
 +--------------------------------------------------------------------+
 | CiviCRM version 5                                                  |
 +--------------------------------------------------------------------+
 | Copyright CiviCRM LLC (c) 2004-2019                                |
 +--------------------------------------------------------------------+
 | This file is a part of CiviCRM.                                    |
 |                                                                    |
 | CiviCRM is free software; you can copy, modify, and distribute it  |
 | under the terms of the GNU Affero General Public License           |
 | Version 3, 19 November 2007 and the CiviCRM Licensing Exception.   |
 |                                                                    |
 | CiviCRM is distributed in the hope that it will be useful, but     |
 | WITHOUT ANY WARRANTY; without even the implied warranty of         |
 | MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.               |
 | See the GNU Affero General Public License for more details.        |
 |                                                                    |
 | You should have received a copy of the GNU Affero General Public   |
 | License and the CiviCRM Licensing Exception along                  |
 | with this program; if not, contact CiviCRM LLC                     |
 | at info[AT]civicrm[DOT]org. If you have questions about the        |
 | GNU Affero General Public License or the licensing of CiviCRM,     |
 | see the CiviCRM license FAQ at http://civicrm.org/licensing        |
 +--------------------------------------------------------------------+
*}
<script src="{$config->resourceBase}/bower_components/d3/d3.min.js"></script>
<script src="{$config->resourceBase}/bower_components/crossfilter2/crossfilter.min.js"></script>
<script src="{$config->resourceBase}/bower_components/dc-2.1.x/dc.min.js"></script>
<style src="{$config->resourceBase}/bower_components/dc-2.1.x/dc.min.css"></style>
<style>
{literal}
  .dc-chart path.domain {
    fill: none;
    stroke: black;
  }
{/literal}
</style>
{literal}
<script type="text/javascript">

function createSWFObject( chartID, divName, xSize, ySize, loadDataFunction ) {

	var data = JSON.parse(window[loadDataFunction](chartID));

  var div = document.getElementById(divName);

  // Figure out width.
  var node = div, foundContainer = false;
  while (node !== document) {
    node = node.parentNode;
    if (node.classList.contains('crm-flashchart')) {
      foundContainer = node;
      break;
    }
  }
	var w=800;
	var h=400;
  if (foundContainer) {
    w = foundContainer.clientWidth - 32;
    h = parseInt(w / 2);
  }

  var chartNode = document.createElement('div');
  var heading = document.createElement('h2');
  heading.textContent = data.title.text;
  heading.style.marginBottom = '1rem';
  heading.style.textAlign = 'center';
  div.appendChild(heading);
  div.appendChild(chartNode);
  var crossfilterData, ndx, dataDimension, dataGroup;

	if (data.elements[0].type === 'bar_glass') {
    crossfilterData = [];
    for (var i=0; i<data.elements[0].values.length; i++) {
      crossfilterData.push({value: data.elements[0].values[i], label: data.x_axis.labels.labels[i]});
    }
    ndx = crossfilter(crossfilterData);
    dataDimension = ndx.dimension(d => d.label);
    dataGroup = dataDimension.group().reduceSum(d => d.value);
    var ordinals = data.x_axis.labels.labels;
    var barChart = dc.barChart(chartNode)
        .width(w)
        .height(h)
        .dimension(dataDimension)
        .group(dataGroup)
        .gap(4) // px
        .x(d3.scale.ordinal(ordinals).domain(ordinals))
        .xUnits(dc.units.ordinal)
        .margins({top: 10, right: 30, bottom: 30, left: 90})
        .elasticY(true)
        .renderLabel(false)
        .renderHorizontalGridLines(true)
        .title(item=> item.key + ': ' + item.value)
        //.turnOnControls(true)
        .renderTitle(true);
  }
  else if (data.elements[0].type === 'pie') {
    crossfilterData = data.elements[0].values;
    ndx = crossfilter(crossfilterData);
    dataDimension = ndx.dimension(d => d.label);
    dataGroup = dataDimension.group().reduceSum(d => d.value);

    var pieChart = dc.pieChart(chartNode)
        .width(w)
        .height(h)
        .radius(parseInt(h / 2) - 5) // define pie radius
        .innerRadius(parseInt(h / 3) - 5) // optional
        .legend(dc.legend().legendText(d => d.name))
        .dimension(dataDimension)
        .group(dataGroup)
        .renderLabel(false)
        .title(item=> item.key + ': ' + item.value)
        .turnOnControls(true)
        .renderTitle(true);
  }
  // Delay rendering so that animation looks good.
  window.setTimeout(() => dc.renderAll(), 1500);
}
</script>
{/literal}
