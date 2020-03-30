class MailMessageModel {
  dynamic id;
  dynamic authorId;
  dynamic authorName;
  dynamic body;
  dynamic createDate;
  dynamic writeDate;
  MailMessageModel(
      {this.id,
      this.authorId,
      this.authorName,
      this.body,
      this.createDate,
      this.writeDate});
}
