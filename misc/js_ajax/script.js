(function(){
  'use strict';

  function createTable(source, target) {
    var ajaxRequest = new XMLHttpRequest();
    var tableRows, tableData, output, targetNode;

    targetNode = document.querySelector(target);

    ajaxRequest.onload = function(e) {
      console.log(e.target.response);
    }

    ajaxRequest.open('GET', source, true);
    ajaxRequest.responseType = 'text';
    ajaxRequest.send();

  }

  createTable('_assets/test.csv', '#one')
  createTable('_assets/test2.csv', '#two')


})();
