class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent(
      {required this.image, required this.title, required this.description});
}

List<OnboardingContent> contens = [
  OnboardingContent(
    title: 'One place for all you work.',
    image: 'assets/images/image1.png',
    description:
        'Task, Docs, Goal, and Chat - customizable to work for everyone.',
  ),
  OnboardingContent(
    title: 'Save one day every week, guaranteed.',
    image: 'assets/images/image2.png',
    description:
        'ClickUp users save one day every week by puting work in one place',
  ),
  OnboardingContent(
    title: 'Personalized to the way you work.',
    image: 'assets/images/image3.png',
    description: 'Customize ClickUp to work for you No opinions, just options.',
  ),
];
