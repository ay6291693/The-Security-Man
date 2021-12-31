class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent({this.image, this.title, this.description});
}

List<OnboardingContent> contents = [
  OnboardingContent(
      image: 'assets/online_platform.json',
      title: 'The Online Platform',
      description:
                 "The Security Man is a Startup Idea that provides an Online Security"
                 " Service to Organizations and Companies for their Properties. "
                 "We Work with the Security Man and the Security Needed Organization on an Online Platform."
  ),
  OnboardingContent(
      image: 'assets/hour-lottie.json',
      title: '24*7 Support',
      description: "Customers Satisfaction will be the priority for Us. "
                   "We provide 24*7 customer support for security complaints. "
                   "We will try to resolve the problem with an efficient solution on time."),
  OnboardingContent(
      image: 'assets/Job-lottie.json',
      title: 'The Job Opportunity',
      description: "Our Start-Up Idea helps Security Man to look for a job. "
                   "And the Online Platform for Security Companies to grow their business with us. "
                   "Online Platform helps their businesses in expanding and growing in the competitive world."),
];
