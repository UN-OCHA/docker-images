<?php
// Specify a default drupal root.
$options['r'] = '/srv/www/html';

/**
 * Restore drush_backend_fork().
 */
if (!function_exists('drush_backend_fork')) {
  function drush_backend_fork($command, $data, $drush_path = null, $hostname = null, $username = null) {
    $data['quiet'] = TRUE;
    $args = explode(" ", $command);
    $command = array_shift($args);
    $site_record = array(
      'remote-host' => $hostname,
      'remote-user' => $username,
      'path-aliases' => array(
        '%drush-script' => $drush_path,
      ),
    );
    $cmd = "(" . _drush_backend_generate_command($site_record, $command, $args, $data, array()) . ' &) > /dev/null';
    drush_op_system($cmd);
  }
}
