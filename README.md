# **Auto FER (Facial Expression Recognition)**


---

I implemented two techniques for auto-FER. 

* First, I retrained AlexNet, used transfer learning for classification. 
* Second, I used AlexNet for feature extraction and cascaded it with an SVM for classification. 

I achieved 93% accuracy with AlexNet and 95% with AlexNet-SVM cascade which is comparable with the contemporary methods that give 96-98%. Data augmentation and training with larger dataset can improve the accuracy with deep learning
