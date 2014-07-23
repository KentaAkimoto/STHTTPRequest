<?php

  // php.ini
  // upload_max_filesize = 100M
  // upload_tmp_dir = "/Library/Server/Web/Data/Sites/Default/tmp"

  echo var_dump($_FILES);

if (is_uploaded_file($_FILES["upfile"]["tmp_name"])) {
  if (move_uploaded_file($_FILES["upfile"]["tmp_name"], "files/" . $_FILES["upfile"]["name"])) {
    chmod("files/" . $_FILES["upfile"]["name"], 0644);
    echo $_FILES["upfile"]["name"] . "をアップロードしました。";
  } else {
    echo "ファイルをアップロードできません。";
  }
} else {
  echo "ファイルが選択されていません。";

}

?>
<html>
	<head>
		<meta charset="UTF-8">
		<title>post_test</title>
	</head>
	<body>
	
	</body>
</html>