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

  setResultSelectionVisibility(state) {
    console.log(state);

    switch(state) {
      case 'hide':
        document.getElementById('result-selection-options').classList.add('hidden');
        break;
      case 'show':
        document.getElementById('result-selection-options').classList.remove('hidden');
        break;
      case true:
        document.getElementById('result-selection-options').classList.remove('hidden');
        break;
      case false:
        document.getElementById('result-selection-options').classList.add('hidden');
        break;
      default:
        document.getElementById('result-selection-options').classList.add('hidden');
    }
  }

  selectResultSet() {
    document.getElementById('pageset').classList.add('hidden');
    document.getElementById('resultset').classList.remove('hidden');
  }

  removeResultSet() {
    document.getElementById('pageset').classList.remove('hidden');
    document.getElementById('resultset').classList.add('hidden');
  }

  toggleAll() {
    console.log('Toggle All');

    var checked = document.querySelectorAll("input[type=checkbox]")[0].checked
    this.checkedState(checked);
    this.setResultSelectionVisibility(checked);
  }

  selectAll() {
    console.log('Select All');
    this.checkedState(true);

    // Show result selection options
    this.setResultSelectionVisibility('show');
  }

  selectNone() {
    console.log('Select None');
    this.checkedState(false);

    // Hide result selection options
    this.setResultSelectionVisibility('hide');
    this.removeResultSet();
  }

  selectBookmarked() {
    console.log('Select Bookmarked');
    this.checkedState(true, 'input.bookmarked[type=checkbox]');

    // Hide result selection options
    this.setResultSelectionVisibility('hide');
    this.removeResultSet();
  }
}
