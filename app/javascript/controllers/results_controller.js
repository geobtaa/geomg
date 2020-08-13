// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="results">
//   <h1 data-target="results.selectAll"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
  }

  checkedState(checked, selector='input[type=checkbox]') {
    var aa = document.querySelectorAll(selector);
    for (var i = 0; i < aa.length; i++){
        aa[i].checked = checked;
    }
  }

  setResultActionsVisibility(state) {
    switch(state) {
      case 'hide':
        document.getElementById('result-selected-options').classList.add('hidden');
        break;
      case 'show':
        document.getElementById('result-selected-options').classList.remove('hidden');
        break;
      default:
        document.getElementById('result-selected-options').classList.add('hidden');
    }
  }

  setResultSelectionVisibility(state) {
    switch(state) {
      case 'hide':
        document.getElementById('result-selection-options').classList.add('hidden');
        break;
      case 'show':
        document.getElementById('result-selection-options').classList.remove('hidden');
        break;
      default:
        document.getElementById('result-selection-options').classList.add('hidden');
    }
  }

  setResultOptionsVisibility(state) {
    switch(state) {
      case true:
        this.setResultSelectionVisibility('show')
        this.setResultActionsVisibility('show')
        break;
      case false:
        this.setResultSelectionVisibility('hide')
        this.setResultActionsVisibility('hide')
        document.getElementById('resultset').classList.add('hidden');
        document.getElementById('pageset').classList.remove('hidden');
        break;
      default:
        this.setResultSelectionVisibility('hide')
        this.setResultActionsVisibility('hide')
    }
  }

  selectResultSet() {
    document.getElementById('pageset').classList.add('hidden');
    document.getElementById('resultset').classList.remove('hidden');

    // Set scope to full resultset
    var el = document.querySelector('#result-selected-options');
    el.setAttribute('data-scope', 'resultset');
  }

  removeResultSet() {
    document.getElementById('pageset').classList.remove('hidden');
    document.getElementById('resultset').classList.add('hidden');

    // Set scope to just pageset
    var el = document.querySelector('#result-selected-options');
    el.setAttribute('data-scope', 'pageset');
  }

  toggleAll() {
    var checked = document.querySelectorAll("input[type=checkbox]")[0].checked
    this.checkedState(checked);
    this.setResultOptionsVisibility(checked);
  }

  selectAll() {
    this.checkedState(true);
    this.setResultSelectionVisibility('show');
    this.setResultActionsVisibility('show')
  }

  selectNone() {
    this.checkedState(false);
    this.setResultSelectionVisibility('hide');
    this.setResultActionsVisibility('hide')
    this.removeResultSet();

    // Set selection scope
    var el = document.querySelector('div#result-selection-options');
    el.setAttribute('data-scope', 'pageset');
  }

  selectBookmarked() {
    console.log('Select Bookmarked');
    this.checkedState(false);
    this.checkedState(true, 'input.bookmarked[type=checkbox]');
    this.setResultSelectionVisibility('hide');
    this.setResultActionsVisibility('show');
    this.removeResultSet();
  }

  checkChecked() {
    var checked = document.querySelectorAll('#results input[type="checkbox"]:checked');
    if(checked.length < 1) {
      this.setResultActionsVisibility('hide');
    } else {
      this.setResultActionsVisibility('show');
    }

    // Guard deselection
    if (checked.length < 20) {
      this.setResultSelectionVisibility('hide');
      // Set selection scope
      var el = document.querySelector('div#result-selection-options');
      el.setAttribute('data-scope', 'pageset');
    } else {
      this.setResultActionsVisibility('show');
    }

    // @TODO: make aware fo resultset count
    // Guard deselection and reselection
    if (checked.length === 20) {
      this.setResultSelectionVisibility('show');
    }

    this.setPagesetURL();
  }

  checkSelectionScope() {
    var el = document.querySelector('#result-selected-options');
    return el.dataset.scope
  }

  setPagesetURL() {
    // Find all checked checkboxes
    var checked = document.querySelectorAll('#results input[type="checkbox"]:checked');

    // Array of friendlier_ids
    var selected = Array.from(checked).map(d => d.dataset.id);

    // Create params for fetch
    var params = new URLSearchParams()
    selected.forEach(function(item, index, array) {
      params.append('ids[]', item)
    })

    // Set attribute value
    var el = document.querySelector('#result-selected-options');
    el.setAttribute('data-pageset', '/documents/fetch.csv?' + params);
  }

  exportCSV() {
    var scope = this.checkSelectionScope();
    var el = document.querySelector('#result-selected-options');
    if(scope === 'pageset') {
      window.location = el.dataset.pageset
    } else {
      window.location = el.dataset.resultset
    }
  }
}
