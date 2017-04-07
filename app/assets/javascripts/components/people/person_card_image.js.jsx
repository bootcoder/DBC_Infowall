var PersonCardImage = React.createClass({

  render: function() {
    var img_tag
    if(this.props.person.staff_type == "Staff"){
      console.log(this.props.person.img_url)
      img_tag = <img src={this.props.person.img_url} className="circle-175px" />

      // img_tag = imageTag(this.props.person.img_url, {alt: 'Staff_Image', className: 'circle-175px'})
    }else if(this.props.person.staff_type == "Mentor"){
      img_tag = <img src={this.props.person.img_url} className="circle-175px" />
    }

        // <Img src={this.props.person.img_url} className ="circle-60px right fullWidth" />
    return (
      <div className="small-12 large-12 columns center">
        {img_tag}
      </div>
    );
  }
});

