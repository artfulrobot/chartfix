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
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<script type="text/javascript" src="{$config->resourceBase}packages/OpenFlashChart/js/json/openflashchart.packed.js"></script>
{literal}
<script type="text/javascript">
function createSWFObject( chartID, divName, xSize, ySize, loadDataFunction ) {
  var cols = [
    '#DCECC9', '#B3DDCC', '#8ACDCE', '#62BED2', '#46AACE', '#3D91BE', '#3577AE', '#2D5E9E', '#24448E', '#1C2B7F', '#162065', '#11174B',
    '#F9CDAC', '#F3ACA2', '#EE8B97', '#E96A8D', '#DB5087', '#B8428C', '#973490', '#742796', '#5E1F88', '#4D1A70', '#3D1459', '#2D0F41',
    '#FDED86', '#FDE86E', '#F9D063', '#F5B857', '#F0A04B', '#EB8A40', '#E77235', '#E35B2C', '#C74E29', '#9D4429', '#753C2C', '#4C3430',
  ];
	var data = JSON.parse(window[loadDataFunction](chartID));
	console.log("data:", data);

	var ctx = document.getElementById(divName);
	var w=800;
	var h=400;
	var p;

	ctx.innerHTML = `<canvas id="${divName}_chart" width="${w}" height="${h}"></canvas>`;
	if (data.elements[0].type === 'bar_glass') {
		p = {
				// The type of chart we want to create
				type: 'bar',

				// The data for our dataset
				data: {
						labels: data.x_axis.labels.labels,
						datasets: [{
								label: data.title.text,
                backgroundColor: cols,
								// borderColor: cols,
								data: data.elements[0].values
						}]
				},

				// Configuration options go here
				options: {
          title: { display: true, text: data.title.text },
        }
		};
	}
	else if (data.elements[0].type === 'pie') {
		p = {
				// The type of chart we want to create
				type: 'pie',

				// The data for our dataset
				data: {
					datasets: [{
						data: data.elements[0].values.map(i => i.value),
						backgroundColor: cols,
					}],
					labels: data.elements[0].values.map(i => i.label),
				},

				// Configuration options go here
				options: {
          title: { display: true, text: data.title.text },
          legend: { position:'right' },
        }
		};

	}
	console.log("args", p);
	var chart = new Chart(ctx.childNodes[0].getContext('2d'), p);
}
</script>
{/literal}
