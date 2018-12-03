<?php

require_once 'createbulkcaseactivities.civix.php';
use CRM_Createbulkcaseactivities_ExtensionUtil as E;

/**
 * Implements hook_civicrm_config().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_config
 */
function createbulkcaseactivities_civicrm_config(&$config) {
  _createbulkcaseactivities_civix_civicrm_config($config);
}

/**
 * Implements hook_civicrm_xmlMenu().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_xmlMenu
 */
function createbulkcaseactivities_civicrm_xmlMenu(&$files) {
  _createbulkcaseactivities_civix_civicrm_xmlMenu($files);
}

/**
 * Implements hook_civicrm_install().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_install
 */
function createbulkcaseactivities_civicrm_install() {
  _createbulkcaseactivities_civix_civicrm_install();
}

/**
 * Implements hook_civicrm_postInstall().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_postInstall
 */
function createbulkcaseactivities_civicrm_postInstall() {
  _createbulkcaseactivities_civix_civicrm_postInstall();
}

/**
 * Implements hook_civicrm_uninstall().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_uninstall
 */
function createbulkcaseactivities_civicrm_uninstall() {
  _createbulkcaseactivities_civix_civicrm_uninstall();
}

/**
 * Implements hook_civicrm_enable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_enable
 */
function createbulkcaseactivities_civicrm_enable() {
  _createbulkcaseactivities_civix_civicrm_enable();
}

/**
 * Implements hook_civicrm_disable().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_disable
 */
function createbulkcaseactivities_civicrm_disable() {
  _createbulkcaseactivities_civix_civicrm_disable();
}

/**
 * Implements hook_civicrm_upgrade().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_upgrade
 */
function createbulkcaseactivities_civicrm_upgrade($op, CRM_Queue_Queue $queue = NULL) {
  return _createbulkcaseactivities_civix_civicrm_upgrade($op, $queue);
}

/**
 * Implements hook_civicrm_managed().
 *
 * Generate a list of entities to create/deactivate/delete when this module
 * is installed, disabled, uninstalled.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_managed
 */
function createbulkcaseactivities_civicrm_managed(&$entities) {
  _createbulkcaseactivities_civix_civicrm_managed($entities);
}

/**
 * Implements hook_civicrm_caseTypes().
 *
 * Generate a list of case-types.
 *
 * Note: This hook only runs in CiviCRM 4.4+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_caseTypes
 */
function createbulkcaseactivities_civicrm_caseTypes(&$caseTypes) {
  _createbulkcaseactivities_civix_civicrm_caseTypes($caseTypes);
}

/**
 * Implements hook_civicrm_angularModules().
 *
 * Generate a list of Angular modules.
 *
 * Note: This hook only runs in CiviCRM 4.5+. It may
 * use features only available in v4.6+.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_angularModules
 */
function createbulkcaseactivities_civicrm_angularModules(&$angularModules) {
  _createbulkcaseactivities_civix_civicrm_angularModules($angularModules);
}

/**
 * Implements hook_civicrm_alterSettingsFolders().
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_alterSettingsFolders
 */
function createbulkcaseactivities_civicrm_alterSettingsFolders(&$metaDataFolders = NULL) {
  _createbulkcaseactivities_civix_civicrm_alterSettingsFolders($metaDataFolders);
}

/**
 * Implements hook_civicrm_entityTypes().
 *
 * Declare entity types provided by this module.
 *
 * @link http://wiki.civicrm.org/confluence/display/CRMDOC/hook_civicrm_entityTypes
 */
function createbulkcaseactivities_civicrm_entityTypes(&$entityTypes) {
  _createbulkcaseactivities_civix_civicrm_entityTypes($entityTypes);
}
