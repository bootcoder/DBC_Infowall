var PersonCardPhase = React.createClass({

  render: function() {

    var bgColor = ""

    if(this.props.person.phase == "Phase 1"){
      bgColor = "bg-orange"
    }else if(this.props.person.phase == "Phase 2"){
      bgColor = "bg-blue"
    }else if(this.props.person.phase == "Phase 3"){
      bgColor = "bg-green"
    }else{
      bgColor = "bg-light-pink"
    }

    return (
      <p className={"center white-text person-text pad-top-1P height-50px "+bgColor}>{this.props.person.staff_type}: {this.props.person.phase}</p>
    );

  }
});
