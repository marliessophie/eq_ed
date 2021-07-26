from pathlib import Path
import os

from PythonServerCode.game_engine.utilies.components.answer import Answer
from PythonServerCode.game_engine.utilies.components.intro import Intro
from PythonServerCode.game_engine.utilies.components.item import Item
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
    answersX1001.append(Answer("Say nothing and see how the discussion evolves.", Score(0, 0),
                          "Y1001", "X1002"))
    answersX1001.append(Answer("Tell Rick that he is being unfair to Morty and he should do the research task instead.",
                               Score(3, 5), "Y1002", "X1005"))
    answersX1001.append(Answer("Say that you think it would be good to take a step back"
                          " and think about which tasks need to be distributed first.", Score(10, 10),
                          "Y1003", "X1008"))
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
    answersX1002.append(Answer("Agree with Rick, you need to get to work!", Score(-10, -10),
                               "Y1004", "Z1001"))
    answersX1002.append(Answer("Say nothing and end the meeting like this.",
                               Score(2, 0), "Y1005", "Z1001"))
    answersX1002.append(Answer("Calmly ask Rick if he thinks that this behaviour is "
                               "appropriate towards the team and ask him to apologise to Morty..", Score(10, 10),
                               "Y1006", "X1003"))
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
                               "Rick was right, you should do the task!", Score(0, 2),
                               "Y1007", "X1002"))
    answersX1005.append(Answer("I really think you should do the task, Rick. After the way you "
                               "spoke to Morty that is the least you can do.",
                               Score(3, 8), "Y1008", "X1006"))
    answersX1005.append(Answer("Well, if you are also not happy to do this research maybe let's "
                               "reconsider what we should do about this assignment. "
                               "And please try to keep friendly vibes.", Score(10, 10),
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
                               Score(2, 2),
                               "Y1010", "X1009"))
    answersX1008.append(Answer("I really think you should do the task, Rick. After the way you "
                               "spoke to Morty that is the least you can do.",
                               Score(8, 5), "Y1011", "X1011"))
    answersX1008.append(Answer("How about we focus on what needs to be done for the task. "
                               "Morty, do you have a suggestion on how to split up work?",
                               Score(10, 10),
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
                               Score(0, 0),
                               "Y1013", "Z1002"))
    answersX1003.append(Answer("Thanks apologising to Morty, Rick. Morty are you happy with this division of work?",
                               Score(10, 10), "Y1014", "X1004"))
    # question_text, number_of_answers, answers, next_question_id
    new_questionX1003 = Question(
        "Rick: Alright, alright. Sorry Morty. Then I will do the research task instead and you guys "
        "look up some statistics and graphs on how peoples perception has developed.",
        2,
        answersX1003,
        None,
    )
    questionX1003 = Item(new_questionX1008, "X1003")








