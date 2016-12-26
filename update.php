<?PHP
/*
Simple versioning system
Original code: /Developer/usr/bin/agvtool next-version -all
*/
$fp = explode("\n", file_get_contents("Version.m"));
$i = 0;
while ($i < count($fp))
{
	if (strpos($fp[$i], "//$VER") > 0)
	{
		$l = $i+1;
		$i = count($fp);
	}
	$i++;
}

if ($l > 0)
{
	$Split = preg_split('/([^0-9]*)([0-9]*)([^0-9]*)/', $fp[$l], -1, PREG_SPLIT_DELIM_CAPTURE);
	$fp[$l] = $Split[1].((int)$Split[2]+1).$Split[3];
	$fp = implode("\n", $fp);
	$fpR = fopen("Version.m", "w");
	fwrite($fpR, $fp);
	fclose($fpR);
	unset($fp);
}
?>