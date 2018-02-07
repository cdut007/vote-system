<!doctype html>
<html class="no-js" lang="">
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="manifest" href="site.webmanifest">
    <link rel="apple-touch-icon" href="icon.png">
    <!-- Place favicon.ico in the root directory -->

    <script
            src="http://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha256-k2WSCIexGzOj3Euiig+TlR8gA0EmPjuc79OEeY5L45g="
            crossorigin="anonymous"></script>

    <style>
        .word_style {
            border: none;
            border-bottom: 1px #000000 solid;
            box-shadow: none;
            outline: none;
            width: 150px;
        }

        .word_style:hover {

        }
    </style>
    <script>
        var textWidth = function (text) {
            var sensor = $('<pre>' + text + '</pre>').css({display: 'none'});
            $('body').append(sensor);
            var width = sensor.width();
            sensor.remove();
            return width;
        };

        var autoWith = function (e) {
            var w = textWidth($(e).val());
            if (w > $(e).width()) {
                $(e).width(w + 20);
            }

            if (w == 0) {
                $(e).width(150);
            }


        }
    </script>
</head>
<body>
<p>输入框随输入内容自动边长</p>
<input id="test" name="xxx" value="" class="word_style" onkeyup="autoWith(this)">
</body>
</html>
