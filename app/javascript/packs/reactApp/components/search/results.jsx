import React from 'react';

import Table from 'react-bootstrap/Table'

class Results extends React.Component {
  constructor(props) {
    super(props);
  }

  __tableRows(record, index) {
    let results = [];
    let headers = [];

    switch (this.props.searchType) {
      case "user":
        results = record.user
        headers = Object.keys(results).concat(["tags"]);
        break;
      case "organization":
        results = record.organization
        headers = Object.keys(results).concat(["tags", "domain_names"]);
        break;
      case "ticket":
        results = record.ticket
        headers = Object.keys(results).concat(["tags"]);
        break;
      default:
        break;
    }

    if (record.tags) {
      results["tags"] = record.tags.map(t => {return t.name})
    }
    if (record.domain_names) {
      results["domain_names"] = record.domain_names.map(d => {return d.name})
    }

    return (
      <tr key={index}>
        {headers.map((header, index) => {
          return this.__tableItem(results[header], index)
        })}
      </tr>
    )
  }

  __tableItem(item, index) {
    return (
      <td key={index}>{String(item)}</td>
    )
  }

  __toTitle(str) {
    str = str.replace(/_/g, " ")
    str = str.toLowerCase().split(" ");
    for (var i = 0; i < str.length; i++) {
      str[i] = str[i].charAt(0).toUpperCase() + str[i].slice(1);
    }
    return str.join(' ');
  }

  __tags() {

  }

  __domains() {

  }

  __buildHeaders(headerName) {
    return (
      <th key={headerName}>{this.__toTitle(headerName)}</th>
    )
  }

  render() {
    if (this.props.searchResults.length > 0) {
      let headers = [];
      switch (this.props.searchType) {
        case "user":
          headers = Object.keys(this.props.searchResults[0].user).concat(["tags"])
          break;
        case "organization":
          headers = Object.keys(this.props.searchResults[0].organization).concat(["tags", "domain_names"])
          break;
        case "ticket":
          headers = Object.keys(this.props.searchResults[0].ticket).concat(["tags"])
          break;
        default:
          break;
      }

      return(
        <div id="landing-page">
          <div className="container" style={{float: "left"}}>
            <h4>Search Results</h4>
            <Table bordered>
              <thead>
              <tr>
                {headers.map(header => {
                  return this.__buildHeaders(header)
                })}
              </tr>
              </thead>
              <tbody>
              {this.props.searchResults.map((record, index) => {
                return this.__tableRows(record, index)
              })}
              </tbody>
            </Table>
          </div>
        </div>
      )
    } else {
      return null
    }


  }
}

export default Results
