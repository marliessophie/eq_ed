from pathlib import Path
import os

from PythonServerCode.game_engine.utilies.components.answer import Answer
from PythonServerCode.game_engine.utilies.components.intro import Intro
from PythonServerCode.game_engine.utilies.components.item import Item
from PythonServerCode.game_engine.utilies.components.level_end import LevelEnd
from PythonServerCode.game_engine.utilies.components.question import Question
from PythonServerCode.game_engine.utilies.components.score import Score


class K:
    level_mapping = {
        '1': 'one',
        '2': 'two',
        '3': 'three',
    }
    path = Path(__file__).parent
    cred = os.path.join(path, 'json_schemas/serviceAccountKey.json')
    introX1000 = Item(
        Intro(
            "Setting: User is in a team meeting setting with 2 NPCs. " \
            "They are discussing how to best approach answering the question" \
            " given in an assignment: \"What is the future of work?\". The " \
            "group should create a presentation answering this question. " \
            "The user first listens to the others discussing. ",
            'X1001',
        ),
        'X1000')

    # question item X1001
    answersX1001 = list()
    answersX1001.append(Answer("Say nothing and see how the discussion evolves.", Score(0, 0), Score(10, 8),
                          "Y1001", "X1002"))
    answersX1001.append(Answer("Tell Rick that he is being unfair to Morty and he should do the research task instead.",
                               Score(3, 5), Score(10, 8), "Y1002", "X1005"))
    answersX1001.append(Answer("Say that you think it would be good to take a step back"
                          " and think about which tasks need to be distributed first.",
                               Score(10, 8), Score(10, 8), "Y1003", "X1008"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1001 = Question(
        "Rick: Alright, now that we have the task I'd say Morty look at news "
        "articles regarding this topic in the last year!" +
        "Morty: I thought we could also..." +
        "Rick: But do it properly this time! I really think we need to be "
        "diligent here. Oh and would be good if you could make a summary for the presentation too.",
        3,
        answersX1001,
        None,
    )
    questionX1001 = Item(new_questionX1001, "X1001")

    # question item X1002
    answersX1002 = list()
    answersX1002.append(Answer("Agree with Rick, you need to get to work!", Score(-10, -10), Score(10, 10),
                               "Y1004", "Z1001"))
    answersX1002.append(Answer("Say nothing and end the meeting like this.",
                               Score(2, 0), Score(10, 10), "Y1005", "Z1001"))
    answersX1002.append(Answer("Calmly ask Rick if he thinks that this behaviour is "
                               "appropriate towards the team and ask him to apologise to Morty..", Score(10, 10),
                               Score(10, 10), "Y1006", "X1003"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1002 = Question(
        "Morty: Hmm maybe we should try and understand the components of the question first and... " +
        "Rick: What is there not to understand? I was pretty clear, was I not?",
        3,
        answersX1002,
        None,
    )
    questionX1002 = Item(new_questionX1002, "X1002")

    # question item X1005
    answersX1005 = list()
    answersX1005.append(Answer("Morty why are you not saying anything? I defended you and now this... "
                               "Rick was right, you should do the task!", Score(0, 2), Score(10, 10),
                               "Y1007", "X1002"))
    answersX1005.append(Answer("I really think you should do the task, Rick. After the way you "
                               "spoke to Morty that is the least you can do.",
                               Score(3, 8), Score(10, 10), "Y1008", "X1006"))
    answersX1005.append(Answer("Well, if you are also not happy to do this research maybe let's "
                               "reconsider what we should do about this assignment. "
                               "And please try to keep friendly vibes.", Score(10, 10), Score(10, 10),
                               "Y1009", "X1007"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1005 = Question(
        "Rick: What is your problem now [name]? You know what I mean. Let's just distribute the tasks as I said!",
        3,
        answersX1005,
        None,
    )
    questionX1005 = Item(new_questionX1005, "X1005")

    # question item X1008
    answersX1008 = list()
    answersX1008.append(Answer("What do you mean he agrees? You have been talking over him this whole time!",
                               Score(2, 2), Score(10, 10),
                               "Y1010", "X1009"))
    answersX1008.append(Answer("I really think you should do the task, Rick. After the way you "
                               "spoke to Morty that is the least you can do.",
                               Score(8, 5), Score(10, 10), "Y1011", "X1011"))
    answersX1008.append(Answer("How about we focus on what needs to be done for the task. "
                               "Morty, do you have a suggestion on how to split up work?",
                               Score(10, 10), Score(10, 10),
                               "Y1012", "X1011"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1008 = Question(
        "Rick: Why would we have to take a step back? I think the tasks are clear. And Morty also agrees with me!",
        3,
        answersX1008,
        None,
    )
    questionX1008 = Item(new_questionX1008, "X1008")

    # question item X1003
    answersX1003 = list()
    answersX1003.append(Answer("This sounds like a good idea, let's go with this!",
                               Score(0, 0), Score(10, 10),
                               "Y1013", "Z1002"))
    answersX1003.append(Answer("Thanks apologising to Morty, Rick. Morty are you happy with this division of work?",
                               Score(10, 10), Score(10, 10), "Y1014", "X1004"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1003 = Question(
        "Rick: Alright, alright. Sorry Morty. Then I will do the research task instead and you guys "
        "look up some statistics and graphs on how peoples perception has developed.",
        2,
        answersX1003,
        None,
    )
    questionX1003 = Item(new_questionX1003, "X1003")

    # question item X1004
    answersX1004 = list()
    answersX1004.append(Answer("Great, then everyone is happy.",
                               Score(5, 0), Score(10, 10),
                               "Y1023", "Z1002"))
    answersX1004.append(Answer("Ok. Morty are you sure you are okay with this?",
                               Score(5, 8), Score(10, 10), "Y1024", "Z1003"))
    answersX1004.append(Answer("Ok. Is there anything else you would like to add Morty? "
                               "And are you sure you are no longer overwhelmed?",
                               Score(10, 10), Score(10, 10), "Y1025", "Z1004"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1004 = Question(
        "Morty: Sorry, I was a bit overwhelmed. Yes, I am happy with this division of work!",
        3,
        answersX1004,
        None,
    )
    questionX1004 = Item(new_questionX1004, "X1004")

    # question item X1006
    answersX1006 = list()
    answersX1006.append(Answer("Great, then everyone is happy.",
                               Score(5, 0), Score(10, 10),
                               "Y1023", "Z1002"))
    answersX1006.append(Answer("Ok. Morty are you sure you are okay with this?",
                               Score(5, 8), Score(10, 10), "Y1024", "Z1003"))
    answersX1006.append(Answer("Ok. Is there anything else you would like to add Morty? "
                               "And are you sure you are no longer overwhelmed?",
                               Score(10, 10), Score(10, 10), "Y1025", "Z1004"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1006 = Question(
        "Rick: I really do not see why I should do the task? Morty you are totally okay with doing the task, right? "
        "Morty: I mean yeah... But as I said I think we should rather...  "
        "Rick: See? Morty is totally happy to do the task. Then the two of us can just look into some graphs"
        " and statistics.",
        3,
        answersX1006,
        None,
    )
    questionX1006 = Item(new_questionX1006, "X1006")

    # question item X1007
    answersX1007 = list()
    answersX1007.append(Answer("Great, then everyone is happy.",
                               Score(0, 0), Score(10, 10),
                               "Y1015", "A1000"))
    answersX1007.append(Answer("Ok. Morty are you sure you are okay with this?",
                               Score(5, 5), Score(10, 10), "Y1016", "Z1006"))
    answersX1007.append(Answer("Great idea Rick. But I would love to hear what ideas you had Morty!"
                               " Care to share? ",
                               Score(10, 10), Score(10, 10), "Y1017", "Z1007"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1007 = Question(
        "Morty: I actually have some ideas, how about we... Rick: So we have the research of news "
        "articles that needs to be done, someone needs to look into statistics release to the topics"
        " and finally we need some nice visuals for the presentation. "
        "Morty: That also sounds good I guess...",
        3,
        answersX1007,
        None,
    )
    questionX1007 = Item(new_questionX1007, "X1007")

    # question item X1009
    answersX1009 = list()
    answersX1009.append(Answer("Rick, I do not care what you say anymore, your behaviour is totally not okay. "
                               "I do not see how we can work together if you act like this. Come Morty, let's go!",
                               Score(-2, 2), Score(10, 10),
                               "Y1018", "Z1008"))
    answersX1009.append(Answer("Ok, it might have just come off that way. Then let us refocus on the task.",
                               Score(8, 5), Score(10, 10), "Y1019", "X1010"))
    answersX1009.append(Answer("Ok. It might have come off wrong. Maybe let's think about the task. "
                               "Morty, do you have any ideas on how to approach this assignment?",
                               Score(10, 10), Score(10, 10), "Y1020", "Z1007"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1009 = Question(
        "Rick: I have not been talking over anyone. "
        "It is not my problem if people cannot handle some factual discussion.",
        3,
        answersX1009,
        None,
    )
    questionX1009 = Item(new_questionX1009, "X1009")

    # question item X1010
    answersX1010 = list()
    answersX1010.append(Answer("No",
                               Score(0, 0), Score(10, 10),
                               "Y1026", "Z1008"))
    answersX1010.append(Answer("Yes",
                               Score(10, 10), Score(10, 10), "Y1027", "Z1007"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1010 = Question(
        "EQ'ed: do you think it is necessary to check in with Morty to see if he has any ideas?",
        2,
        answersX1010,
        None,
    )
    questionX1010 = Item(new_questionX1010, "X1010")

    # question item X1011
    answersX1011 = list()
    answersX1011.append(Answer("Sure. This works.",
                               Score(0, 0), Score(10, 10),
                               "Y1021", "Z1006"))
    answersX1011.append(Answer("Great input both. Are you happy with this Morty?",
                               Score(10, 10), Score(10, 10), "Y1022", "Z1007"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1011 = Question(
        "Morty: Sure, I think it would be nice to 1) find some statistics about how peoples opinion evolved, "
        "2) conduct some expert interviews and 3) do some research in recent news articles. "
        "Rick: Ok, sure. Then Morty, you do 1, you do 2 and I will do 3.",
        2,
        answersX1011,
        None,
    )
    questionX1011 = Item(new_questionX1011, "X1011")

    # level_end item Z1001
    new_level_endZ1001 = LevelEnd(
        False,
        "Level failed! Think about it. If you were Morty, would you have appreciated to be treated this way?",
    )
    level_endZ1001 = Item(new_level_endZ1001, "Z1001")

    # level_end item Z1002
    new_level_endZ1002 = LevelEnd(
        False,
        "Level failed! You should have properly checked in with Morty if he feels comfortable in the team setting.",
    )
    level_endZ1002 = Item(new_level_endZ1002, "Z1002")

    # level_end item Z1003
    new_level_endZ1003 = LevelEnd(
        True,
        "Level completed! Thanks facilitating the discussion. Good job!",
    )
    level_endZ1003 = Item(new_level_endZ1003, "Z1003")

    # level_end item Z1004
    new_level_endZ1004 = LevelEnd(
        True,
        "Level completed! Thanks facilitating the discussion so well. Great job on communicating.",
    )
    level_endZ1004 = Item(new_level_endZ1004, "Z1004")

    # level_end item A1000
    level_endA1000 = Item(LevelEnd(
        False,
        "Try again! Are you sure everyone in the team is happy with the situation? "
        "Maybe worth checking in with Morty again.",
    ), "A1000")

    # level_end item Z1006
    level_endZ1006 = Item(LevelEnd(
        True,
        "Level completed! Thanks facilitating the discussion. Good job!",
    ), "Z1006")

    # level_end item Z1007
    level_endZ1007 = Item(LevelEnd(
        True,
        "Level completed! Thanks facilitating the discussion so well. Great job on empathy and communication.",
    ), "Z1007")

    # level_end item Z1008
    level_endZ1008 = Item(LevelEnd(
        False,
        "Level failed! You should have properly made sure everyone felt comfortable "
        "in this group setting and tried to find a common solution.  ",
    ), "Z1008")

    # intro level 2
    introX2000 = Item(
        Intro(
            "Setting: You are currently working on on an individual project in undergrad. "
            "This level comprises the first kick-off meeting with your supervisor around timeline "
            "and milestones. First, the supervisor begins the meeting. Listen carefully and have fun!",
            'X2001',
        ),
        'X2000')

    # question item X2001
    answersX2001 = list()
    answersX2001.append(Answer("I don't really have any expectations.",
                               Score(0, 0), Score(10, 10),
                               "Y2001", "X2002"))
    answersX2001.append(Answer("My main interest is learning something new. I also really want "
                               "to make sure we are on the same page regarding expectations. "
                               "What is important for you in these projects?",
                               Score(10, 10), Score(10, 10), "Y2002", "X2002"))
    answersX2001.append(Answer("I would really like to have a creative component to my project.",
                               Score(5, 3), Score(10, 10), "Y2003", "X2006"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2001 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX2001,
        None,
    )
    questionX2001 = Item(new_questionX2001, "X2001")

    # question item X2002
    answersX2002 = list()
    answersX2002.append(Answer("I think daily updates are way too much, especially given two weekly"
                               " meetings a week. Let's do no updates and one meeting per week.",
                               Score(0, 0), Score(10, 10),
                               "Y2004", "Z2001"))
    answersX2002.append(Answer("I am not sure I will be able to handle the quantity of updates. "
                               "I would suggest one meeting start of the week and one update end of the week.",
                               Score(10, 5), Score(10, 10), "Y2005", "X2003"))
    answersX2002.append(Answer("I appreciate how much time you are aiming to put into this. Yet I would suggest"
                               " one update message and meeting per week, as some steps may take a while and I "
                               "would be sending you updates on outdated progress.",
                               Score(10, 10), Score(10, 10), "Y2006", "X2004"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2002 = Question(
        "EQ'ed: You think that daily updates might be a bit much in terms of updates. "
        "Try to communicate this to your supervisor.",
        3,
        answersX2002,
        None,
    )
    questionX2002 = Item(new_questionX2002, "X2002")

    # question item X2003
    answersX2003 = list()
    answersX2003.append(Answer("No offense, I appreciate your enthusiasm but this amount of meetings "
                               "will actually hinder my progress, not help it.",
                               Score(2, 0), Score(10, 10),
                               "Y2007", "Z2002"))
    answersX2003.append(Answer("I am grateful you are willing to put in so much time into this, yet I"
                               " think my work will be constantly iterated and too many updates might "
                               "be more confusing than helpful, as some approaches might change in "
                               "the matter of days.",
                               Score(8, 7), Score(10, 10), "Y2008", "X2005"))
    answersX2003.append(Answer("I appreciate how much time you are aiming to put into this. Yet I "
                               "would suggest one update message and meeting per week, as some steps "
                               "may take a while and I would be sending you updates on outdated progress. "
                               "Would you be okay with this? Or is there any reason why you would prefer "
                               "more updates? ",
                               Score(10, 10), Score(10, 10), "Y2009", "X2004"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2003 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX2003,
        None,
    )
    questionX2003 = Item(new_questionX2003, "X2003")

    # question item X2004
    answersX2004 = list()
    answersX2004.append(Answer("I think it is too early to discuss milestones. Let me get back to you.",
                               Score(0, 0), Score(10, 10),
                               "Y2028", "Z2004"))
    answersX2004.append(Answer("I would like to make a draft by next week, before the meeting is that okay?",
                               Score(8, 5), Score(10, 10), "Y2029", "X2010"))
    answersX2004.append(Answer("I would suggest that I propose a couple of approaches I would like to follow,"
                               " which you provide feedback on. And then we can define a corresponding "
                               "structure with milestones. I would make a draft before the next meeting, "
                               "if that's okay?",
                               Score(10, 10), Score(10, 10), "Y2030", "X2010"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2004 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX2004,
        None,
    )
    questionX2004 = Item(new_questionX2004, "X2004")

    # question item X2005
    answersX2005 = list()
    answersX2005.append(Answer("That would be fine, yes. I will then do that instead of the additional weekly updates.",
                               Score(3, 0), Score(10, 10),
                               "Y2010", "Z2003"))
    answersX2005.append(Answer("Of course, I would be more than happy to!",
                               Score(10, 10), Score(10, 10), "Y2011", "X2004"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2005 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        2,
        answersX2005,
        None,
    )
    questionX2005 = Item(new_questionX2005, "X2005")

    # question item X2006
    answersX2006 = list()
    answersX2006.append(Answer("I am looking to explore different approaches. "
                               "In terms of expectations I am not sure. What would you suggest?",
                               Score(5, 8), Score(10, 10),
                               "Y2013", "X2002"))
    answersX2006.append(Answer("I want to work very freely and go with the flow. "
                               "So I guess I don't really have any expectations from you.",
                               Score(3, 0), Score(10, 10), "Y2012", "X2007"))
    answersX2006.append(Answer("I wish to test different approaches to the topic. "
                               "I would suggest that I propose a couple of approaches, "
                               "which you provide feedback on. And then we can define a "
                               "corresponding structure with milestones.",
                               Score(10, 10), Score(10, 10), "Y2014", "X2010"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2006 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX2006,
        None,
    )
    questionX2006 = Item(new_questionX2006, "X2006")

    # question item X2007
    answersX2007 = list()
    answersX2007.append(Answer("I have to disagree. I think I can get most value from this project"
                               " if I explore different approaches freely and do not follow a "
                               "predefined structure.",
                               Score(0, 0), Score(10, 10),
                               "Y2015", "Z2004"))
    answersX2007.append(Answer("I understand where you are coming from. Then I will stick to your "
                               "structure and suggestions.",
                               Score(5, 8), Score(10, 10), "Y2016", "X2008"))
    answersX2007.append(Answer("I appreciate your input. However, I would suggest a combined approach. "
                               "How about I list and structure the approaches I would like to explore,"
                               " you provide feedback and we build the structure together?",
                               Score(10, 10), Score(10, 10), "Y2017", "X2009"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2007 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX2007,
        None,
    )
    questionX2007 = Item(new_questionX2007, "X2007")

    # question item X2008
    answersX2008 = list()
    answersX2008.append(Answer("Yes, sure. This is exactly what I wanted!",
                               Score(0, 5), Score(10, 10),
                               "Y2018", "Z2005"))
    answersX2008.append(Answer("Actually, sorry to pivot on this. I would really appreciate "
                               "a combined approach, meaning we both create the structure together. "
                               "Would this be okay for you? ",
                               Score(10, 10), Score(10, 10), "Y2019", "X2009"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2008 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        2,
        answersX2008,
        None,
    )
    questionX2008 = Item(new_questionX2008, "X2008")

    # question item X2009
    answersX2009 = list()
    answersX2009.append(Answer("Yes, I think it would be important to discuss milestones. "
                               "I would suggest to define weekly milestones and goals, and iterate if "
                               "necessary. ",
                               Score(8, 5), Score(10, 10),
                               "Y2023", "Z2006"))
    answersX2009.append(Answer("Yes, I think we should discuss milestones and timeline. "
                               "I would propose weekly milestones with associated goals. Also I think"
                               " we should aim to have a pre-final meeting after 3/4 of the project, "
                               "to make sure we are wrapping up properly.",
                               Score(10, 10), Score(10, 10), "Y2024", "Z2007"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2009 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        2,
        answersX2009,
        None,
    )
    questionX2009 = Item(new_questionX2009, "X2009")

    # question item X2010
    answersX2010 = list()
    answersX2010.append(Answer("That timeline is very unrealistic. I will not be able to make that in time!",
                               Score(0, 0), Score(10, 10),
                               "Y2020", "A2000"))
    answersX2010.append(Answer("I am not sure I can create all of this by tomorrow, maybe I can "
                               "do some research and get back to you in our next meeting?",
                               Score(5, 8), Score(10, 10), "Y2021", "X2011"))
    answersX2010.append(Answer("I am not sure I will manage by tomorrow. However I would suggest I send"
                               " you an outline of the approaches I wish to look at by tomorrow, and then"
                               " create a more detailed schedule before the next meeting?",
                               Score(10, 10), Score(10, 10), "Y2022", "X2011"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2010 = Question(
        "EQ'ed: You know it is unrealistic for you to create this by tomorrow. "
        "Try to communicate to Jane that you will not be able to do this in time.",
        3,
        answersX2010,
        None,
    )
    questionX2010 = Item(new_questionX2010, "X2010")

    # question item X2011
    answersX2011 = list()
    answersX2011.append(Answer("Sure, if that is part of the project.",
                               Score(3, 3), Score(10, 10),
                               "Y2025", "Z2007"))
    answersX2011.append(Answer("Yes, of course, I am happy to do that.",
                               Score(5, 5), Score(10, 10), "Y2026", "Z0008"))
    answersX2011.append(Answer("No problem at all. I will make sure to send you a draft"
                               " of the final communication I would send out.",
                               Score(10, 10), Score(10, 10), "Y2027", "Z0009"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX2011 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX2011,
        None,
    )
    questionX2011 = Item(new_questionX2011, "X2011")

    # level_end item A2000
    level_endA2000 = Item(LevelEnd(
        False,
        "Try again! Are you sure this is the best way to communicate this to Jane?",
    ), "A2000")

    # level_end item Z2001
    level_endZ2001 = Item(LevelEnd(
        False,
        "Level failed! Think about it. If you were Jane, would you have "
        "appreciated this form of communication?",
    ), "Z2001")

    # level_end item Z2002
    level_endZ2002 = Item(LevelEnd(
        False,
        "Level failed! Think about it. If you were Jane, do you think you would feel "
        "as if your efforts were appreciated? She really wants to be engaged.",
    ), "Z2002")

    # level_end item Z2003
    level_endZ2003 = Item(LevelEnd(
        False,
        "Level failed! Think about it. Jane really wanted you to provide lots of "
        "updates as she is so engaged in the project. It is not okay to just assume "
        "that she does not want additional weekly updates.",
    ), "Z2003")

    # level_end item Z2004
    level_endZ2004 = Item(LevelEnd(
        False,
        "Level failed! Think about it. You disregarded Jane's wishes and expectations"
        " how to design the project. Next time maybe try to incorporate her wishes more.",
    ), "Z2004")

    # level_end item Z2005
    level_endZ2005 = Item(LevelEnd(
        False,
        "Level failed! Think about it. You did reasonably on showing empathy, "
        "however you were not able to communicate what you wanted till then end,"
        " and now agreed to an approach you did not want. ",
    ), "Z2005")

    # level_end item Z2006
    level_endZ2006 = Item(LevelEnd(
        True,
        "Level failed! Think about it. You did reasonably on showing empathy, "
        "however you were not able to communicate what you wanted till then end,"
        " and now agreed to an approach you did not want. ",
    ), "Z2006")

    # level_end item Z2007
    level_endZ2007 = Item(LevelEnd(
        True,
        "Level completed! You did well on communication and empathy, overall. "
        "Also you added additional points to the discussion, which helped "
        "communication and goal setting.",
    ), "Z2007")

    # level_end item Z0008
    level_endZ2008 = Item(LevelEnd(
        True,
        "Level completed! You did well on communication and empathy, overall. "
        "Also you added additional points to the discussion, which helped "
        "communication and goal setting.",
    ), "Z0008")

    # level_end item Z0009
    level_endZ2009 = Item(LevelEnd(
        True,
        "Level completed! Great job on communicating and showing empathy "
        "for Jane's points by compromising. You could have not done better!",
    ), "Z0009")

    # intro level 3
    introX3000 = Item(
        Intro(
            "Setting: You have prepared a client presentation as well as corresponding "
            "analysis and results. You now have a meeting with your boss, Jackie, to get some "
            "feedback. Despite your best efforts, you have not achieved the results you were hoping for, "
            "and now have to communicate this to Jackie.",
            'X3001',
        ),
        'X3000')

    # question item X3001
    answersX3001 = list()
    answersX3001.append(Answer("Both the analysis and the presentation are looking good. There "
                               "were a couple points with the analysis though that did not go completely smooth.",
                               Score(0, 0), Score(10, 10),
                               "Y3001", "X3002"))
    answersX3001.append(Answer("The presentation framework is looking okay overall. Yet there are a couple"
                               " of points regarding the analysis I would like to discuss. ",
                               Score(8, 5), Score(10, 10), "Y3002", "X3003"))
    answersX3001.append(Answer("There have been some complications with the analysis, would you like me "
                               "to walk you through it?",
                               Score(10, 10), Score(10, 10), "Y3003", "X3004"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3001 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX3001,
        None,
    )
    questionX3001 = Item(new_questionX3001, "X3001")

    # question item X3002
    answersX3002 = list()
    answersX3002.append(Answer("Oh, it was just minor points that did not go as planned, "
                               "if you do not want to know the details, I will not bother you with them.",
                               Score(0, 0), Score(10, 10),
                               "Y3004", "Z3001"))
    answersX3002.append(Answer("Well, not exactly. There were some issues with the analysis. ",
                               Score(8, 3), Score(10, 10), "Y3005", "X3005"))
    answersX3002.append(Answer("Actually, there were some complications around the analysis. "
                               "Would you like me to take you through them?",
                               Score(10, 10), Score(10, 10), "Y3006", "X3003"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3002 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX3002,
        None,
    )
    questionX3002 = Item(new_questionX3002, "X3002")

    # question item X3003
    answersX3003 = list()
    answersX3003.append(Answer("Put very simply - we ran into issues. The results were not as we had hoped.",
                               Score(0, 0), Score(10, 10),
                               "Y3015", "X3008"))
    answersX3003.append(Answer("In a nutshell: we followed the discussed technical implementation, "
                               "yet the results we got did not match our expectations. "
                               "We still summarised it for the presentation.",
                               Score(10, 5), Score(10, 10), "Y3016", "X3008"))
    answersX3003.append(Answer("To summarise: the implementation was correct, yet the results not as "
                               "good as we had hoped. We however have already consolidated why the "
                               "results are not great and thought of alternative approaches.",
                               Score(10, 10), Score(10, 10), "Y3017", "X3010"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3003 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX3003,
        None,
    )
    questionX3003 = Item(new_questionX3003, "X3003")

    # question item X3004
    answersX3004 = list()
    answersX3004.append(Answer("The results simply were not as good as we had hoped. "
                               "There was no way to see this coming.",
                               Score(0, 0), Score(10, 10),
                               "Y3023", "X3008"))
    answersX3004.append(Answer("The results were not as good as we had hoped. I think it "
                               "would have been difficult to predict, but at least this "
                               "is a learning for us and the client.",
                               Score(10, 5), Score(10, 10), "Y3024", "X3010"))
    answersX3004.append(Answer("I think the key is communicating this to the client. These things happen,"
                               " we should try and focus on the way forward for them.",
                               Score(10, 10), Score(10, 10), "Y3025", "X3010"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3004 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX3004,
        None,
    )
    questionX3004 = Item(new_questionX3004, "X3004")

    # question item X3005
    answersX3005 = list()
    answersX3005.append(Answer("Well, we did our best with the analysis but things did "
                               "not work as planned. There is nothing we could have done about that.",
                               Score(0, 0), Score(10, 10),
                               "Y3007", "Z3002"))
    answersX3005.append(Answer("Despite our best efforts, some bits of the analysis "
                               "did not return the expected results.",
                               Score(8, 3), Score(10, 10), "Y3008", "X3006"))
    answersX3005.append(Answer("Despite putting in lots of work, the analysis did not "
                               "yield the desired results. Would you like me to explain in detail? ",
                               Score(10, 10), Score(10, 10), "Y3009", "X3007"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3005 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX3005,
        None,
    )
    questionX3005 = Item(new_questionX3005, "X3005")

    # question item X3006
    answersX3006 = list()
    answersX3006.append(Answer("This really does not have anything to with the work that was put in."
                               " Sometimes these analysis just do not work as planned.",
                               Score(0, 0), Score(10, 10),
                               "Y3010", "Z3002"))
    answersX3006.append(Answer("The team did put in lots of work. However the analysis unfortunately "
                               "did not go as hoped. Let me take you through the details of the complications.",
                               Score(10, 10), Score(10, 10), "Y3011", "X3007"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3006 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        2,
        answersX3006,
        None,
    )
    questionX3006 = Item(new_questionX3006, "X3006")

    # question item X3007
    answersX3007 = list()
    answersX3007.append(Answer("Sorry, but I really do not think this was our fault. "
                               "I would appreciate if we could have a factual discussion about this.",
                               Score(0, 0), Score(10, 10),
                               "Y3012", "Z3003"))
    answersX3007.append(Answer("With all due respect, these things can happen. There was no error in implementation."
                               " It is simply that the results did not quite match our expectations.",
                               Score(5, 5), Score(10, 10), "Y3013", "Z3003"))
    answersX3007.append(Answer("Let's take a step back. I would like to walk you through "
                               "our approach and results in detail.",
                               Score(10, 10), Score(10, 10), "Y3014", "X3003"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3007 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX3007,
        None,
    )
    questionX3007 = Item(new_questionX3007, "X3007")

    # question item X3008
    answersX3008 = list()
    answersX3008.append(Answer("I really do not know. I am sorry.",
                               Score(0, 0), Score(8, 5),
                               "Y3018", "Z3004"))
    answersX3008.append(Answer("Of course. What we have tried to convey in the presentation is "
                               "a) the work we have done and b) what we would suggest going forward.",
                               Score(8, 5), Score(8, 5), "Y3019", "X3009"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3008 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        2,
        answersX3008,
        None,
    )
    questionX3008 = Item(new_questionX3008, "X3008")

    # question item X3009
    answersX3009 = list()
    answersX3009.append(Answer("Well, I really do not think there is much more we could have done. "
                               "I am sure the client will understand this.",
                               Score(5, 3), Score(10, 10),
                               "Y3021", "Z3005"))
    answersX3009.append(Answer("I would again emphasise that these things happen and focus the "
                               "discussion towards what is important to get good results on the way forward.",
                               Score(10, 10), Score(10, 10), "Y3022", "Z3005"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3009 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        2,
        answersX3009,
        None,
    )
    questionX3009 = Item(new_questionX3009, "X3009")

    # question item X3010
    answersX3010 = list()
    answersX3010.append(Answer("There was just no time to predict this.",
                               Score(0, 0), Score(10, 10),
                               "Y3026", "X3008"))
    answersX3010.append(Answer("We thought the results would have been more helpful. We should "
                               "have tested the approaches earlier though. And will do so next time.",
                               Score(8, 5), Score(10, 10), "Y3027", "X3011"))
    answersX3010.append(Answer("We hoped the results would have been better. Earlier "
                               "testing should help next time. Also here, I will get you in the "
                               "loop earlier next time. So we can align on what to do and communicate to the client.",
                               Score(10, 10), Score(10, 10), "Y3028", "X3011"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3010 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        3,
        answersX3010,
        None,
    )
    questionX3010 = Item(new_questionX3010, "X3010")

    # question item X3011
    answersX3011 = list()
    answersX3011.append(Answer("Yes, that makes sense.",
                               Score(5, 8), Score(10, 10),
                               "Y3029", "Z3006"))
    answersX3011.append(Answer("I will definitely explain the underlying approach, results and way forward. "
                               "Generally I think it is important that we show a united front, and "
                               "make sure the client understands exactly what is going on.",
                               Score(10, 10), Score(10, 10), "Y3030", "Z3007"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX3011 = Question(
        "EQ'ed: given what you just heard, what would you do now?",
        2,
        answersX3011,
        None,
    )
    questionX3011 = Item(new_questionX3011, "X3011")

    # level_end item Z3001
    level_endZ3001 = Item(LevelEnd(
        False,
        "Level failed! Think about it. You completely missed the mark on communicating "
        "your difficulties with your boss. This is very important and best to bring up "
        "earlier rather than later. Make sure to be more upfront next time.",
    ), "Z3001")

    # level_end item Z3002
    level_endZ3002 = Item(LevelEnd(
        False,
        "Level failed! Think about it. You missed the mark on communicating your "
        "difficulties with your boss. It would be best to communicate what "
        "happened and not get defensive.",
    ), "Z3002")

    # level_end item Z3003
    level_endZ3003 = Item(LevelEnd(
        False,
        "Level failed! Despite your boss not communicating properly, it is important to "
        "stay calm and professional. Try to re-focus the conversation on the content "
        "of the discussion instead of getting defensive.",
    ), "Z3003")

    # level_end item Z3004
    level_endZ3004 = Item(LevelEnd(
        False,
        "Level failed! A key aspect of empathy is understanding what Jackie cares about. "
        "In this case that is delivering value to the client. "
        "You should try to communicate focused on what she cares about.",
    ), "Z3004")

    # level_end item Z3005
    level_endZ3005 = Item(LevelEnd(
        True,
        "Level completed! You did a good job understanding Jackie's intentions and communicating correctly.",
    ), "Z3005")

    # level_end item Z3006
    level_endZ3006 = Item(LevelEnd(
        True,
        "Level completed! You did a great job on empathy and communication. Well done!",
    ), "Z3006")

    # level_end item Z3007
    level_endZ3007 = Item(LevelEnd(
        True,
        "Level completed! Amazing, you did an incredible job! Especially "
        "considering Jackie and the client the entire time really "
        "shows strong empathy and communication skills!",
    ), "Z3007")





