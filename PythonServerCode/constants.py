from pathlib import Path
import os

from PythonServerCode.game_engine.utilies.components.answer import Answer
from PythonServerCode.game_engine.utilies.components.intro import Intro
from PythonServerCode.game_engine.utilies.components.item import Item
from PythonServerCode.game_engine.utilies.components.level_end import LevelEnd
from PythonServerCode.game_engine.utilies.components.question import Question
from PythonServerCode.game_engine.utilies.components.score import Score


class K:
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







