class TicketStatistic {
  dynamic index;
  dynamic category;
  dynamic ticketCount;
  dynamic ticketsAvgTime;
  dynamic ticketsDone;
  dynamic xCatColor;

  TicketStatistic(
      {this.category,
      this.index,
      this.ticketCount,
      this.ticketsAvgTime,
      this.ticketsDone,
      this.xCatColor});

  TicketStatistic.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    ticketCount = json['ticket_count'];
    ticketsAvgTime = json['tickets_avg_time'];
    ticketsDone = json['tickets_done'];
    xCatColor = json['x_cat_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) data['category'] = this.category;
    if (this.ticketCount != null) data['ticket_count'] = this.ticketCount;
    if (this.ticketsAvgTime != null)
      data['tickets_avg_time'] = this.ticketsAvgTime;
    if (this.ticketsDone != null) data['tickets_done'] = this.ticketsDone;
    if (this.xCatColor != null) data['x_cat_color'] = this.xCatColor;
    return data;
  }
}
