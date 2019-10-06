# chartfix

This is proof of concept pre-core merge request.

The master branch replaces core open flash chart with chartjs (from CDN).
This draws on a `<canvas>` which makes copying the image easy.

The dc branch replaces them with 'dc' drawn charts using the dc (and
crossfilter and d3) bundled with CiviCRM. This creates a `<svg>` chart
which means you get a resolution independent chart that you could (given
nice browser plugins/skills) edit in an external editor.

Note that the d3 and dc included in core are very old. They still work but
they are notably outdated. The latest verion of Civisualize, for example,
uses more up to date libraries.

