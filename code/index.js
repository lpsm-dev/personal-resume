#!/usr/bin/env node

"use strict";

var console = require("console");
var inquirer = require("inquirer");
var chalk = require("chalk");

var response = chalk.bold.yellow;
var resume = require("./assets/resume.json");

var resumePrompts = {
    type: "list",
    name: "resumeOptions",
    message: "What do you want to know about me?",
    choices: [...Object.keys(resume), "Exit"]
};

function resumeHandler() {
  inquirer.prompt(resumePrompts).then(answer => {
      if (answer.resumeOptions == "Exit") {
          return;
      }
      var option = answer.resumeOptions;
      console.log(response("--------------------------------------"));
      resume[`${option}`].forEach(info => {
          console.log(response("|   => " + info));
      });
      console.log(response("--------------------------------------"));
      // console.log(resume[`${option}`]);
      inquirer
          .prompt({
              type: "list",
              name: "exitBack",
              message: "Go back or Exit?",
              choices: ["Back", "Exit"]
          })
          .then(choice => {
              if (choice.exitBack == "Back") {
                  resumeHandler();
              } else {
                  return;
              }
          });
  });
}

function main() {
  console.log("Hello, My name is Lucca Pessoa and Welcome to my CLI Resume");
  resumeHandler();
}

main();
