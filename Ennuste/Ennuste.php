<?php
exec('Rscript --vanilla Ennuste.R', $result);
echo $result;