import React, { Component } from 'react'

import SearchPage from './search/search.jsx'

class LandingPage extends React.Component {
  constructor(props) {
    super(props);
  }

  componentDidMount() {
    // Don't really need this
  }


  render() {
    return(
      <div id="landing-page">
        <SearchPage/>
      </div>
    )
  }
}

export default LandingPage
