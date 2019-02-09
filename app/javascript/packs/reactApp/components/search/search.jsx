import React from 'react';

import Button from 'react-bootstrap/Button';
import ButtonGroup from 'react-bootstrap/ButtonGroup'
import Dropdown from 'react-bootstrap/Dropdown'
import Form from 'react-bootstrap/Form'
import Row from 'react-bootstrap/Row'

import $ from 'jquery'

import Results from './results.jsx'

class SearchPage extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      searchText: "",
      searchResults: [],
      textValue: "",
      activeType: "user",
      items: ["id", "url", "external_id", "name", "alias", "active", "verified", "shared", "locale", "timezone", "email", "phone", "signature", "suspended", "role", "organization_id", "created_at", "last_login_at"],
      currentItem: "Select Search Field",
      loading: false
    }
  }

  __switchActiveType(activeType) {
    // Switch to another search type
    this.setState({
      activeType: activeType,
      currentItem: "Select Search Field",
      searchText: "",
      textValue: "",
      searchResults: []
    });

    // Pull dropdown items for the new search type
    let textDropdowns = [];
    switch (activeType) {
      case "user":
        textDropdowns = ["id", "url", "external_id", "name", "alias", "active", "verified", "shared", "locale", "timezone", "email", "phone", "signature", "suspended", "role", "organization_id", "created_at", "last_login_at"]
        break;
      case "organization":
        textDropdowns = ["id", "url", "external_id", "name", "details", "shared_tickets", "created_at"]
        break;
      case "ticket":
        textDropdowns = ["id", "url", "ticket_id", "external_id", "ticket_type", "subject", "description", "priority", "status", "via", "has_incidents", "requester_id", "created_at"]
        break;
      default:
        break;
    }

    this.setState({
      items: textDropdowns
    });
  }

  __search() {
    const { searchText, activeType, currentItem } = this.state;
    const params = {
      searchText,
      searchField: currentItem
    };

    this.setState({
      loading: true
    });

    $.ajax({
      type: "GET",
      url: `/${activeType}s/search`,
      data: params,
      complete: this.__handleSuccess.bind(this)
    });
  }

  __handleSuccess(result) {
    if (result && result.responseJSON) {
      this.setState({
        searchResults: result.responseJSON.results,
        loading: false
      });
    }

  }

  __handleTextChange(e) {
    this.setState({
      searchText: e.target.value,
      textValue: e.target.value
    });
  }

  __selectItem(item) {
    this.setState({
      currentItem: item
    });
  }

  __dropdownItems(item) {
    return (
      <Dropdown.Item key={item} href="#" onClick={this.__selectItem.bind(this, item)}>{item}</Dropdown.Item>
    )
  }

  __searchForm() {
    const { items, currentItem, textValue } = this.state;

    return (
      <div>
        <br/>
        <Form>
          <Form.Group as={Row} controlId="formHorizontalRow">
            <div className="container">
              <div style={{float: "left"}}>
                {(() => {
                  if (items.length > 0) {
                    return (
                      <Dropdown>
                        <Dropdown.Toggle variant="info" id="dropdown-field-select">
                          {currentItem}
                        </Dropdown.Toggle>
                        <Dropdown.Menu>
                          <div className="item-rows">
                            {items.map((item) => {
                              return(<Dropdown.Item key={item} href="#" onClick={this.__selectItem.bind(this, item)}>{item}</Dropdown.Item>)
                            })}
                          </div>
                        </Dropdown.Menu>
                      </Dropdown>
                    )
                  }
                })()}
              </div>
              <div className="container" style={{float: "left", width: "50%"}}>
                <Form.Control
                  type="text"
                  value={textValue}
                  placeholder=""
                  onChange={this.__handleTextChange.bind(this)}
                  onKeyPress={event => {
                    if (event.key === "Enter") {
                      event.preventDefault();
                      this.__search();
                    }
                  }}
                />
              </div>
            </div>
          </Form.Group>
        </Form>
      </div>
    )
  }

  render() {
    const { activeType, searchResults, loading } = this.state;

    let content;
    let userButtonClassName = "info";
    let orgButtonClassName = "outline-info";
    let ticketButtonClassName = "outline-info";

    switch (activeType) {
      case "user":
        content = this.__searchForm();
        userButtonClassName = "info";
        orgButtonClassName = "outline-info";
        ticketButtonClassName = "outline-info";
        break;
      case "organization":
        content = this.__searchForm();
        userButtonClassName = "outline-info";
        orgButtonClassName = "info";
        ticketButtonClassName = "outline-info";
        break;
      case "ticket":
        content = this.__searchForm();
        userButtonClassName = "outline-info";
        orgButtonClassName = "outline-info";
        ticketButtonClassName = "info";
        break;
      default:
        break;
    }

    return(
      <div>
        <div className="search-page container">
          <h1>Search for a User, Organization, or Ticket</h1>
          <br/>
          <ButtonGroup aria-label="Select Search Type">
            <Button variant={userButtonClassName} onClick={this.__switchActiveType.bind(this, "user")}>User</Button>
            <Button variant={orgButtonClassName} onClick={this.__switchActiveType.bind(this, "organization")}>Organization</Button>
            <Button variant={ticketButtonClassName} onClick={this.__switchActiveType.bind(this, "ticket")}>Ticket</Button>
          </ButtonGroup>
          <br/>
          <br/>
          {content}
          <Button variant="info" onClick={this.__search.bind(this)}>Search</Button>
          <br/>
          <br/>
        </div>
        {(() => {
          if (loading === true) {
            return (<div className="container">Loading...</div>)
          } else {
            return (
              <Results searchResults={searchResults} searchType={activeType}/>
            )
          }
        })()}
      </div>

    )
  }
}

export default SearchPage
