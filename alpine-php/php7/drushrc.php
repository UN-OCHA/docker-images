<?php
// Specify a default drupal root.
$options['r'] = '/srv/www/html';

// What table *data* do we not need to backup or sync?
$options['structure-tables'] = array(
  'common' => array(
    'accesslog',
    'batch',
    'cache',
    'cache_*',
    'ctools_css_cache',
    'ctools_object_cache',
    'flood',
    'history',
    'queue',
    'semaphore',
    'sessions',
    'watchdog',
  ),
  'caches' => array(
    'cache',
    'cache_*',
    'ctools_css_cache',
    'ctools_object_cache',
  ),
);

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
