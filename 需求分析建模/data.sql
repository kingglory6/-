use mall;
insert into client values(null,'onehero','18374094701','liubin.b@qq.com','123456');
insert into client values(null,'张三','18374095624','zhangsan@qq.com','123456');
insert into client values(null,'李四','15342684701','lisi@qq.com','123456');
insert into client values(null,'王五','14725684132','wanwu@qq.com','123456');

select * from client;


insert into address values(null,'刘彬彬','18374094701','中南林业科技大学',1);
insert into address values(null,'刘彬彬','18374094701','长沙民政职业技术学院',1);
insert into address values(null,'张三','123456789','湖南长沙xxxx',2);
insert into address values(null,'王五','1234567891','湖南长沙雨花区xxxxx',4);

select * from address;


insert into category values(null,'手机');
insert into category values(null,'电脑');
insert into category values(null,'配件');
insert into category values(null,'阅读器');


select * from category;


insert into brand values(null,'小米');
insert into brand values(null,'三星');
insert into brand values(null,'苹果');
insert into brand values(null,'谷歌');
insert into brand values(null,'华硕');
insert into brand values(null,'戴尔');
insert into brand values(null,'神舟');

select * from brand;

insert into commodity values(null,'小米9','2999','小米9.....','0','0',200,1,1);
insert into commodity values(null,'三星s10','5999','s10.....','0','0',200,1,2);
insert into commodity values(null,'iphone x','7000','iphone x.....','0','0',200,1,3);
insert into commodity values(null,'macbook pro','10000','macbook pro...','0','0',200,2,3);
insert into commodity values(null,'华硕电脑','6500','华硕...','0','0',200,2,5);
insert into commodity values(null,'nexus 6','2200','nexus 6...','0','0',200,1,4);

select * from commodity;

insert into cart values(1,1,1);
insert into cart values(1,4,1);
insert into cart values(1,3,1);
insert into cart values(2,6,1);
insert into cart values(3,5,1);
insert into cart values(4,2,1);

select * from cart;


