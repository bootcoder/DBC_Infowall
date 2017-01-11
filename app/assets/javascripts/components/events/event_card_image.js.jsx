var EventCardImage = React.createClass({

  render: function() {
    if(this.props.event.card_type == 'workshop'){
      img_tag = <img src={this.props.event.img_url} className ="circle-60px right fullWidth" />
    }else {
      img_tag = <Img src={this.props.event.img_url} className ="circle-60px right fullWidth" />
    }
    return (
      <div className="small-3 large-3 columns no-pad-left">
        {img_tag}
      </div>
    );
  }
});
