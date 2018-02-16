<?php
try
{
	$bdd = new PDO('mysql:host=localhost;dbname=exempla;charset=utf8', 'root', '');
}
catch(Exception $e)
{
        die('Erreur : '.$e->getMessage());
}

$reponse = $bdd->query('SELECT segment FROM personnages WHERE reference=\'David\'');

echo 'Les exempla avec' . $donnees['reference'] .'sont les suivants:';

while ($donnees = $reponse->fetch())
{
	echo  $donnees['segment'] . ',';
}

$reponse->closeCursor();

?>