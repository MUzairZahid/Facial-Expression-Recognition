# **Auto FER (Facial Expression Recognition)**


---

I implemented two techniques for auto-FER. 

* First, I retrained AlexNet, used transfer learning for classification. 
* Second, I used AlexNet for feature extraction and cascaded it with an SVM for classification. 

I achieved 93% accuracy with AlexNet and 95% with AlexNet-SVM cascade which is comparable with the contemporary methods that give 96-98%. Data augmentation and training with larger dataset can improve the accuracy with deep learning

I used [JAFFE Data Set](https://http://www.kasrl.org/jaffe.html) to train my both models.

## The Japanese Female Facial Expression (JAFFE) Database:
The database contains 213 images of 7 facial expressions (6 basic facial expressions + 1 neutral) posed by 10 Japanese female models. Each image has been rated on 6 emotion adjectives by 60 Japanese subjects. 

![example_dataset](example_dataset.PNG)
